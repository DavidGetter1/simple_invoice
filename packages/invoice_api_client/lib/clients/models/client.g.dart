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
          userId: $checkedConvert('userId', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          address: $checkedConvert(
              'address',
              (v) => v == null
                  ? null
                  : Address.fromJson(v as Map<String, dynamic>)),
          phoneNumber: $checkedConvert('phoneNumber', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
          creationDate: $checkedConvert('creationDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
          modifiedDate: $checkedConvert('modifiedDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
          id: $checkedConvert('id', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'address': instance.address?.toJson(),
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'creationDate': instance.creationDate?.toIso8601String(),
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
    };
