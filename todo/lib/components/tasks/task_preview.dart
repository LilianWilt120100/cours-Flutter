import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class TaskPreview extends StatelessWidget {
  const TaskPreview(
      {Key? key, required this.task, required this.onTaskSelected})
      : super(key: key);

  final Task? task;
  final Function onTaskSelected;

  @override
  Widget build(BuildContext context) {
    Widget getIconAccordingToCompleted() {
      return (task!.completed)
          ? const Icon(Icons.check)
          : const Icon(Icons.timelapse);
    }

    return ListTile(
      tileColor: task!.completed ? Color.fromARGB(255, 118, 212, 121) : Color.fromARGB(255, 230, 114, 114),
      title: Text(task!.content),
      onTap: () => onTaskSelected(task),
      trailing: getIconAccordingToCompleted(),
    );
  }
}