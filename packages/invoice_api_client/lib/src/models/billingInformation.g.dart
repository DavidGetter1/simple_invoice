// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'billingInformation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillingInformation _$BillingInformationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BillingInformation',
      json,
      ($checkedConvert) {
        final val = BillingInformation(
          taxNumber: $checkedConvert('taxNumber', (v) => v as String),
          germanUstId: $checkedConvert('germanUstId', (v) => v as String),
          streetName: $checkedConvert('streetName', (v) => v as String),
          paymentInformation: $checkedConvert(
              'paymentInformation',
              (v) => v == null
                  ? null
                  : PaymentInformation.fromJson(v as Map<String, dynamic>)),
          streetNumber: $checkedConvert('streetNumber', (v) => v as String),
          postalCode: $checkedConvert('postalCode', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
          phoneNumber: $checkedConvert('phoneNumber', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$BillingInformationToJson(BillingInformation instance) =>
    <String, dynamic>{
      'taxNumber': instance.taxNumber,
      'germanUstId': instance.germanUstId,
      'streetName': instance.streetName,
      'streetNumber': instance.streetNumber,
      'postalCode': instance.postalCode,
      'city': instance.city,
      'phoneNumber': instance.phoneNumber,
      'paymentInformation': instance.paymentInformation?.toJson(),
    };
