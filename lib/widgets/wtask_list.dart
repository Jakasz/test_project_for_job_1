import 'package:flutter/material.dart';
import 'package:test_app/path_viewer.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({Key? key, required this.resultsList}) : super(key: key);
  final List resultsList;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        flex: 1,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: resultsList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 1,
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PathViewer(resultList: resultsList[index])));
                  },
                  title: Text(resultsList[index].toString()),
                ),
              );
            }),
      ),
    ]);
  }
}
