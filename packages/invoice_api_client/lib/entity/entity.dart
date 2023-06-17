import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../items/models/item.dart';
part 'entity.g.dart';

@JsonSerializable(explicitToJson: true)
class Entity extends Equatable {
  Entity({required this.id, required this.userId});
  String id;
  String userId;

  setId(String id) {
    this.id = id;
  }

  setUserId(String userId) {
    this.userId = userId;
  }

  @override
  List<Object?> get props => [id, userId];
}
