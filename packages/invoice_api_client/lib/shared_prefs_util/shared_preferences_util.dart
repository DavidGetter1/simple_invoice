import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../task/task.dart';

class SharedPrefUtil<S, T extends Task<S>> {
  addTaskToList(String key, T value) async {
    print("adding task to list");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Task<S>> list = (prefs.getStringList(key) ?? [])
        .map((e) => Task<S>.fromJson(jsonDecode(e)))
        .toList();
    list.add(value);
    print("added");
    prefs.setStringList(key, list.map((e) => jsonEncode(e.toJson())).toList());
    print("added to shared prefs");
  }

  Future<List<Task<S>>> getTaskList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Task<S>> list = await (prefs.getStringList(key) ?? [])
        .map((e) => Task<S>.fromJson(jsonDecode(e)))
        .toList();
    return list;
  }

  Future<bool> removeTaskFromList(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Task<S>> list = (prefs.getStringList(key) ?? [])
        .map((e) => Task<S>.fromJson(jsonDecode(e)))
        .toList();
    bool removed = list.remove(value);
    prefs.setStringList(key, list.map((e) => jsonEncode(e.toJson())).toList());
    return removed;
  }
}
