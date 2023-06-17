// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_modify_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModifiedState _$InvoiceModifiedStateFromJson(
        Map<String, dynamic> json) =>
    InvoiceModifiedState(
      id: json['id'] as String,
      items: [],
    );

Map<String, dynamic> _$InvoiceModifiedStateToJson(
        InvoiceModifiedState instance) =>
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
