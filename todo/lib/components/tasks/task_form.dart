import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/tasks_collection.dart';
import 'package:todo/models/task.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:todo/data/tasks.dart' as data;

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  TaskFormState createState() {
    return TaskFormState();
  }
}

class TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController contentController = TextEditingController();
    TextEditingController completedController = TextEditingController();
    Map? arguments;

    try {
      arguments = ModalRoute.of(context)!.settings.arguments as Map;
      contentController.text = arguments['task'].content;
    } catch (e) {
      arguments = null;
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(child: Text('Tâche à effectuer'))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description vide !!!';
                }
                return null;
              },
            ),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(child: Text('Tâche complétée ?'))),
          Center(
              child: ToggleSwitch(
            minWidth: 90.0,
            initialLabelIndex: 1,
            cornerRadius: 20.0,
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            labels: const ['Oui', 'Non'],
            icons: const [Icons.check, Icons.close],
            activeBgColors: const [
              [Color.fromARGB(255, 118, 212, 121)],
              [Color.fromARGB(255, 230, 114, 114)]
            ],
            onToggle: (index) {
              if (index == 0) {
                completedController.text = 'true';
              } else {
                completedController.text = 'false';
              }
            },
          )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Consumer<TasksCollection>(
                  builder: (context, collection, child) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sauvegardé'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                        if (arguments != null) {
                          collection.update(
                              arguments['task'],
                              completedController.text == 'true',
                              contentController.text);
                        } else {
                          collection.create(Task(
                              data.tasks.length,
                              contentController.text,
                              completedController.text == 'true',
                              DateTime.now()));
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Sauvegarder la tâche'),
                  ),
                );
              })),
        ],
      ),
    );
  }
}