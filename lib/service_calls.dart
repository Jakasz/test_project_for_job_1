import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:test_app/algorithm/pathfinder.dart';
import 'package:test_app/models/node_model.dart';
import 'package:test_app/task_list.dart';

import 'models/node_model.dart';

class ServiceCalls extends StatefulWidget {
  const ServiceCalls({Key? key, required this.urlString}) : super(key: key);
  final String urlString;

  @override
  State<ServiceCalls> createState() => _ServiceCallsState();
}

class _ServiceCallsState extends State<ServiceCalls> {
  var isLoading = true;
  late Nodes allNodes;
  List resultsList = [];
  double percentage = 0.2;
  bool enabledButton = true;
  bool weGot500 = false;
  String error = '';

  @override
  initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [Text('Calls')],
        ),
      ),
      body: isLoading
          ? Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 40,
                percent: percentage,
                center: Text("${percentage * 100}"),
              ),
            ],
          ))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !weGot500 ?
          const Text(
              'All calculation has finished. You can send your results to server')
              : Text(error),
          CircularPercentIndicator(
            radius: 40,
            percent: percentage,
            center: Text("${percentage * 100}"),
          ),
          ElevatedButton(
              onPressed: !enabledButton ? null : () {
                isLoading = true;
                percentage = 0.2;
                execPost();
              },
              child: const Text('Send results to server')),
        ],
      ),
    );
  }

  getData() async {
    var response = await http.get(Uri.parse(widget.urlString));
    allNodes = Nodes.fromJson(jsonDecode(response.body));
    for (var i = 0; i < allNodes.data.length; i++) {
      final pathfinder = Pathfinder();
      resultsList.add(pathfinder.findPath(
          allNodes.data[i].start.x,
          allNodes.data[i].start.y,
          allNodes.data[i].end.x,
          allNodes.data[i].end.y));
      setState(() {
        percentage = percentage + 0.1;
      });
    }
    setState(() {
      percentage = 1;
      isLoading = false;
    });
  }

  void execPost() async {
    await postData();
    if (!mounted) return;
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => TaskList(resultList: resultsList)));
  }


  postData() async {
    for (var i = 0; i < resultsList.length; i++) {
      if (!isLoading) {
        break;
      }
      List tempResults = [];
      List castedList = resultsList.toList();
      tempResults = castedList[i];
      var bodyString = "[";
      for (var i = 0; i < tempResults.length; i++) {
        if (i != 0) {
          bodyString = "$bodyString,";
        }
        bodyString =
        "$bodyString{\"x\":${int.parse(tempResults[i].toString()[0])},";
        bodyString =
        "$bodyString\"y\":${int.parse(tempResults[i].toString()[2])}}";
      }
      setState(() {
        percentage = percentage + 0.15;
      });
      bodyString = "$bodyString]";
      Map<String, String> headers = {"Content-type": "application/json"};
      try {
        var response = await http.post(Uri.parse(widget.urlString),
            body:
            "[{\"id\": \"id\",\"result\": {\"steps\": $bodyString,\"path\": \"${tempResults
                .toString()}\"}}]",
            headers: headers);
        if (response.statusCode == 200) {
          //Я получаю 500
        }
      }
      catch (e) {
        setState(() {
          isLoading = false;
          weGot500 = true;
          error = e.toString();
        });
      }
      break;
    }

    setState(() {
      percentage = 1;
      isLoading = false;
    });
  }


}
