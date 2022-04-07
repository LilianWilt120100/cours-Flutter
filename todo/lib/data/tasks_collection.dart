import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:http/http.dart' as http;

class TasksCollection extends ChangeNotifier {
  late List<Task> Tasks;

  TasksCollection() {
    Tasks = [];
  }

  factory TasksCollection.fromJson(List<dynamic> array) {
    TasksCollection tasksCollection = TasksCollection();
    for (var element in array) {
      tasksCollection.Tasks.add(Task.fromJson(element));
    }
    return tasksCollection;
  }

  void create(Task task) async {
    final response =
        await http.post(Uri.parse('https://jsonplaceholder.typicode.com/todos'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'title': task.content,
              'completed': task.completed.toString(),
              'userId': task.id.toString()
            }));

    if (response.statusCode == 201) {
      Tasks.add(task);
      notifyListeners();
    } else {
      throw Exception('Failed to create task');
    }
  }

  void update(Task task, bool completed, String content) async {
    final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/${task.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': content,
          'completed': completed.toString(),
          'userId': task.id.toString()
        }));

    if (response.statusCode == 200) {
      Tasks.remove(task);
      Tasks.add(Task(task.id, content, completed, task.createdAt));
      notifyListeners();
    } else {
      throw Exception('Failed to update task');
    }
  }

  void delete(Task task, BuildContext context, Function hideDetails) async {
    final response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/${task.id}'));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Voulez-vous vraiment supprimer cette tâche ?'),
        action: SnackBarAction(
          label: 'Oui',
          onPressed: () {
            Tasks.remove(task);
            hideDetails();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tâche supprimée'),
                duration: Duration(seconds: 1),
              ),
            );
            notifyListeners();
          },
        ),
      ));
    } else {
      throw Exception('Failed to delete task');
    }
  }

  getAll() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

    if (response.statusCode == 200) {
      Tasks = TasksCollection.fromJson(jsonDecode(response.body)).Tasks;
      notifyListeners();
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}