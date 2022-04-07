import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails(
      {Key? key,
      required this.task,
      required this.hideDetails,
      required this.confirmDelete})
      : super(key: key);

  final Task? task;
  final Function hideDetails;
  final Function confirmDelete;

  void close() {
    hideDetails();
  }

  void delete(task) {
    confirmDelete(task);
  }

  @override
  Widget build(BuildContext context) {
    String date = DateTime.parse(task!.createdAt.toString())
        .toLocal()
        .toString()
        .split(' ')[0];

    Widget getIconAccordingToCompleted() {
      return (task!.completed)
          ? const Icon(Icons.check)
          : const Icon(Icons.timelapse);
    }

    return Container(
      child: Column(
        children: [
          IconButton(
            onPressed: () => close(),
            icon: const Icon(Icons.close),
            color: Colors.red,
          ),
          getIconAccordingToCompleted(),
          Text(task!.content, textAlign: TextAlign.center),
          Text('Créé le : ' + date),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton.icon(
              onPressed: () => delete(task),
              icon: const Icon(Icons.delete, size: 18),
              label: const Text("Supprimer"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/one_task',
                    arguments: {'task': task});
              },
              icon: const Icon(Icons.edit, size: 18),
              label: const Text("Editer"),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[800],
                onPrimary: Colors.white,
              ),
            )
          ])
        ],
      ),
      color: Colors.grey[400],
      width: double.infinity,
    );
  }
}