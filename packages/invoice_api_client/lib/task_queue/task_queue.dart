import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

class TaskQueue<T> {
  List<QueueTask> taskList = [];

  late int interval;

  bool isRunning = false;

  TaskQueue({this.interval = 30000, required this.taskStream}) {
    taskStream.listen((queueTask) async {
      taskList.add(queueTask);
      if (!isRunning) await run();
    });
  }

  Stream<QueueTask> taskStream;

  bool get isEmpty => taskList.isEmpty;

  bool addTask(QueueTask task) {
    print("added item to taskqueue");
    taskList.add(task);
    return true;
  }

  bool replaceTask(int index, QueueTask task) {
    taskList[index] = task;

    print("replaced item in taskqueue");
    return true;
  }

  Future<void> run() async {
    print("running");
    if (isRunning) return;
    isRunning = true;
    print("running taskqueue. # of items in queue: ${taskList.length}");
    List<int> indicesToRemove = [];
    await Timer.periodic(Duration(seconds: 5), (timer) async {
      await Future.forEach(taskList, (QueueTask task) async {
        try {
          print("running task");
          await task.run();
          print("task succesful");
          indicesToRemove.add(taskList.indexOf(task));
        } on SocketException {
          // do nothing
        } catch (e) {
          indicesToRemove.add(taskList.indexOf(task));
          print(e);
          print("task failed");
        }
      });
      print("indicesToRemove: $indicesToRemove");
      indicesToRemove.reversed.forEach((index) {
        print(index);
        taskList.removeAt(index);
      });
      if (taskList.isEmpty) timer.cancel();
      isRunning = false;
    });
  }

  void removeTask(int i) {
    taskList.removeAt(i);
  }
}

class QueueTask {
  final Function task;
  final Function? callback;
  final Function? onError;

  QueueTask({this.onError, required this.task, this.callback});

  Future<void> run() async {
    try {
      await task();
      if (callback != null) callback!();
    } catch (e) {
      print("im run catch: $e");
      if (onError != null) onError!();
      rethrow;
    }
  }
}
