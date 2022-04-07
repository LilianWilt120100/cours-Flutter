import 'package:todo/models/task.dart';
import 'package:faker/faker.dart';
import 'dart:math';

var tasks = List<Task>.generate(
    30,
    (index) => Task(
        index, faker.lorem.sentence(), Random().nextBool(), DateTime.now()));