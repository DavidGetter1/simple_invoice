// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_query_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClientFetchedState _$ClientFetchedStateFromJson(Map<String, dynamic> json) =>
    ClientFetchedState(
      client: Client.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ClientFetchedStateToJson(ClientFetchedState instance) =>
    <String, dynamic>{
      'client': instance.client.toJson(),
    };

OperationCompletedState _$ClientListFetchedStateFromJson(
        Map<String, dynamic> json) =>
    OperationCompletedState(
      clientList: (json['clientList'] as List<dynamic>)
          .map((e) => Client.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClientListFetchedStateToJson(
        OperationCompletedState instance) =>
    <String, dynamic>{
      'clientList': instance.clientList.map((e) => e.toJson()).toList(),
    };

FailureState _$FailureStateFromJson(Map<String, dynamic> json) => FailureState(
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$FailureStateToJson(FailureState instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
    };
