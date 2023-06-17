// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_mutate_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientMutatedState _$ClientCreatedStateFromJson(Map<String, dynamic> json) =>
    ClientMutatedState(
      id: json['id'] as String,
    );

Map<String, dynamic> _$ClientCreatedStateToJson(ClientMutatedState instance) =>
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
