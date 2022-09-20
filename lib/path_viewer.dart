import 'package:flutter/material.dart';

class PathViewer extends StatelessWidget {
  PathViewer({Key? key, required this.resultList}) : super(key: key);
  final List resultList;
  final List allDots = [
    0.0,
    1.0,
    2.0,
    3.0,
    0.1,
    1.1,
    2.1,
    3.1,
    0.2,
    1.2,
    2.2,
    3.2,
    0.3,
    1.3,
    2.3,
    3.3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Path"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              color: Colors.blue,
              child: GridView.builder(
                  itemCount: allDots.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    return !resultList.contains(allDots[index])
                        ? Material(
                            child: Container(
                            color: Colors.blueGrey,
                            child: Center(
                              child: Text(
                                allDots[index].toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ))
                        : resultList.indexOf(allDots[index]) == 0
                            ? Material(
                                child: Container(
                                color: Colors.teal,
                                child: Center(
                                  child: Text(
                                    allDots[index].toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ))
                            : resultList.indexOf(allDots[index]) ==
                                    resultList.length - 1
                                ? Material(
                                    child: Container(
                                    color: Colors.green,
                                    child: Center(
                                      child: Text(
                                        allDots[index].toString(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ))
                                : Material(
                                    child: Container(
                                    color: Colors.lightGreen,
                                    child: Center(
                                      child: Text(
                                        allDots[index].toString(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ));
                  }),
            ),
          ),
          Text(resultList.toString())
        ],
      ),
    );
  }
}
