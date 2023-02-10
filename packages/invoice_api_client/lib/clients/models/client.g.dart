// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Client',
      json,
      ($checkedConvert) {
        final val = Client(
          userId: $checkedConvert('userId', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          streetName: $checkedConvert('streetName', (v) => v as String),
          streetNumber: $checkedConvert('streetNumber', (v) => v as String),
          postalCode: $checkedConvert('postalCode', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
          phoneNumber: $checkedConvert('phoneNumber', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
          creationDate: $checkedConvert(
              'creationDate', (v) => DateTime.parse(v as String)),
          modifiedDate: $checkedConvert(
              'modifiedDate', (v) => DateTime.parse(v as String)),
          id: $checkedConvert('_id', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'streetName': instance.streetName,
      'streetNumber': instance.streetNumber,
      'postalCode': instance.postalCode,
      'city': instance.city,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'creationDate': instance.creationDate.toIso8601String(),
      'modifiedDate': instance.modifiedDate.toIso8601String(),
    };
