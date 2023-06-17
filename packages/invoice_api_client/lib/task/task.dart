import 'package:invoice_api_client/items/models/item.dart';
import 'package:invoice_api_client/task/serializable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable(explicitToJson: true)
class Task<T> {
  Task({required this.method, this.data, this.id});

  final Method method;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final T? data;
  final String? id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          method == other.method &&
          data == other.data &&
          id == other.id;

  static T? _fromJson<T>(Object? json) {
    print("doing _fromJson");
    print(json == {});
    if (json == null) return null;
    if (json is Map<String, dynamic>) {
      //TODO potential problem, do these fields have to be required?
      //TODO add for each type
      if (json.containsKey('tax') && json.containsKey('discount')) {
        return Item.fromJson(json) as T;
      }
    } else if (json is List) {
      /// here we handle Lists of JSON maps
      if (json.isEmpty) return [] as T;

      /// Inspect the first element of the List of JSON to determine its Type
      Map<String, dynamic> _first = json.first as Map<String, dynamic>;
      bool _isItem =
          _first.containsKey('tax') && _first.containsKey('discount');

      if (_isItem) {
        return json.map((_json) => Item.fromJson(_json)).toList() as T;
      }
    }

    /// We didn't recognize this JSON map as one of our model classes, throw an error
    /// so we can add the missing case
    throw ArgumentError.value(
        json,
        'json',
        'OperationResult._fromJson cannot handle'
            ' this JSON payload. Please add a handler to _fromJson.');
  }

  //TODO this is a mess, clean it up

  static Object _toJson<T>(T? object) {
    if (object == null) return {};
    print(object.runtimeType);
    if (object is Serializable) {
      return object.toJson();
    } else if (object is List) {
      if (object.isEmpty) return [];

      if (object.first is Serializable) {
        return object.map((t) => t.toJson()).toList();
      }
    }

    /// It's not a List & it's not Serializable, this is a design issue
    throw ArgumentError.value(
        object,
        'Cannot serialize to JSON',
        'Task._toJson this object or List either is not '
            'Serializable or is unrecognized.');
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

enum Method { DELETE, UPDATE, INSERT }
