import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/tasks.dart' as data;
import 'package:todo/components/tasks/task_master.dart';
import 'package:todo/components/tasks/task_details.dart';
import 'package:todo/data/tasks_collection.dart';
import 'package:todo/models/task.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  Task? selectedTask;
  bool showSnackBar = false;

  void showDetails(Task task) {
    setState(() {
      selectedTask = task;
    });
  }

  void hideDetails() {
    setState(() {
      selectedTask = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/create_task');
          },
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child:
              Consumer<TasksCollection>(builder: (context, collection, child) {
            collection.getAll();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                selectedTask != null
                    ? TaskDetails(
                        task: selectedTask,
                        hideDetails: hideDetails,
                        confirmDelete: (task) {
                          collection.delete(task, context, hideDetails);
                        })
                    : Container(),
                TaskMaster(
                  tasks: collection.Tasks,
                  showDetails: showDetails,
                ),
              ],
            );
          }),
        ));
  }
}