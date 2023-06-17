import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:authentication/authentication.dart';
import 'package:invoice_api_client/api_client/api_client.dart';
import 'package:invoice_api_client/entity/entity.dart';
import 'package:invoice_api_client/response/response.dart';
import 'package:invoice_api_client/shared_prefs_util/shared_preferences_util.dart';
import 'package:invoice_api_client/task_queue/task_queue.dart';
import 'package:invoice_api_client/task/task.dart';
import 'package:objectid/objectid.dart';

abstract class Repository<T extends Entity> {
  Repository({required ApiClient this.apiClient}) {
    _sharedPrefs.getTaskList(T.runtimeType.toString()).then((list) {
      list.forEach((element) {
        print("adding task to stream controller");
        streamController.add(element);
      });
    });
    StreamTransformer<Task<T>, QueueTask> taskToQueueTask =
        new StreamTransformer<Task<T>, QueueTask>.fromHandlers(
            handleData: transformTaskToQueueTask);
    taskQueue = TaskQueue<T>(
      taskStream: streamController.stream.transform(taskToQueueTask),
    );
    streamController.stream.listen((event) async {
      _sharedPrefs.addTaskToList(T.runtimeType.toString(), event as Task<T>);
      print("adding task to list");
      _taskList.add(event);
      List<Task<T>> list =
          await _sharedPrefs.getTaskList(T.runtimeType.toString());
      list.forEach((element) {
        print(element.method);
      });
    });
  }

  SharedPrefUtil<T, Task<T>> _sharedPrefs = new SharedPrefUtil<T, Task<T>>();

  void transformTaskToQueueTask(Task<T> task, EventSink sink) {
    if (task.method == Method.DELETE) {
      QueueTask queueTask = QueueTask(
        onError: () {
          _sharedPrefs.removeTaskFromList(T.runtimeType.toString(), task);
          _list.add(task.data!);
        },
        task: () async {
          await apiClient.delete(task.id!);
        },
        callback: () {
          _sharedPrefs.removeTaskFromList(T.runtimeType.toString(), task);
          _taskList.remove(task);
        },
      );
      sink.add(queueTask);
    } else if (task.method == Method.INSERT) {
      QueueTask queueTask = QueueTask(
        onError: () {
          _sharedPrefs.removeTaskFromList(T.runtimeType.toString(), task);
          _list.remove(task.data);
        },
        task: () async {
          await apiClient.insert(task.data);
        },
        callback: () {
          _sharedPrefs.removeTaskFromList(T.runtimeType.toString(), task);
          _taskList.remove(task);
        },
      );
      sink.add(queueTask);
    } else if (task.method == Method.UPDATE) {
      QueueTask queueTask = QueueTask(
        onError: () {
          _sharedPrefs.removeTaskFromList(T.runtimeType.toString(), task);
          //TODO revert changes???
        },
        task: () async {
          await apiClient.update(task.data);
        },
        callback: () {
          _sharedPrefs.removeTaskFromList(T.runtimeType.toString(), task);
          _taskList.remove(task);
        },
      );
      sink.add(queueTask);
    }
  }

  late TaskQueue taskQueue;

  final ApiClient apiClient;

  late AuthenticationRepository _authenticationRepository;

  String _userId = "uninitialized";

  void _onUserIdChanged(String id) {
    if (_userId == id) return;
    _userId = id;
    print("ItemRepository: _onUserIdChanged($id)");
    getByQuery({}, false);
  }

  List<T> _list = [];

  void setList(List<T> list) {
    _list = list;
  }

  List<T> get entityList => _list;

  int _skip = 0;

  List<Task<T>> _taskList = [];

  StreamController<Task<T>> streamController =
      StreamController<Task<T>>.broadcast();

  void setAuthenticationRepository(
      AuthenticationRepository authenticationRepository) {
    _authenticationRepository = authenticationRepository
      ..userId.listen(_onUserIdChanged);
  }

  Future<T> get(String id) {
    return apiClient.getById(id);
  }

  Future<void> getByQuery(Map<String, String> query, bool pagination) async {
    query['user_id'] = _userId;
    Response<T> response = await apiClient.get(query);
    if (!pagination) {
      query['skip'] = '0';
      _list.clear();
    }
    _list.addAll(response.list);
    _skip += response.lastN;
  }

  Future<void> delete(String id) async {
    _list.removeWhere((item) => item.id == id);
    try {
      await apiClient.delete(id);
    } on SocketException {
      streamController.add(Task<T>(method: Method.DELETE, id: id));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> insert(T data) async {
    data.setUserId(_userId);
    data.setId(new ObjectId().toString());
    _list.add(data);
    try {
      await apiClient.insert(data);
    } on SocketException {
      streamController.add(Task<T>(method: Method.INSERT, data: data));
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> update(T data) async {
    int index = _list.indexWhere((element) => element.id == data.id);
    _list.replaceRange(index, index + 1, [data]);
    try {
      await apiClient.update(data);
    } on SocketException {
      streamController.add(Task(method: Method.UPDATE, data: data));
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
