import 'package:flutter/material.dart';
import 'package:test_app/widgets/wtask_list.dart';

class TaskList extends StatelessWidget {

  const TaskList({Key? key, required this.resultList}) : super(key: key);
  final List resultList;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Task list'),
      ),
      body: TaskListWidget(resultsList: resultList),
    );
  }
}
