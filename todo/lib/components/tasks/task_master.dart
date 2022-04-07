import 'package:flutter/material.dart';
import 'package:todo/components/tasks/task_preview.dart';
import 'package:todo/models/task.dart';

class TaskMaster extends StatelessWidget {
  const TaskMaster({Key? key, required this.tasks, required this.showDetails})
      : super(key: key);

  final List<Task>? tasks;
  final Function showDetails;


  void onTaskSelected(Task task) {
    showDetails(task);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: tasks!.length,
            itemBuilder: (context, index) {
              final task = tasks![index];
              return TaskPreview(task: task, onTaskSelected: onTaskSelected);
            }));
  }
}