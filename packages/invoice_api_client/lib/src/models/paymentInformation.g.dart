// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'paymentInformation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInformation _$PaymentInformationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaymentInformation',
      json,
      ($checkedConvert) {
        final val = PaymentInformation(
          type: $checkedConvert('type', (v) => v as String),
          details: $checkedConvert('details', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$PaymentInformationToJson(PaymentInformation instance) =>
    <String, dynamic>{
      'type': instance.type,
      'details': instance.details,
    };
