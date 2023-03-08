// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_create_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCreatedState _$ItemCreatedStateFromJson(Map<String, dynamic> json) =>
    ItemCreatedState(
      id: json['id'] as String,
    );

Map<String, dynamic> _$ItemCreatedStateToJson(ItemCreatedState instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

FailureState _$FailureStateFromJson(Map<String, dynamic> json) => FailureState(
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$FailureStateToJson(FailureState instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
    };
