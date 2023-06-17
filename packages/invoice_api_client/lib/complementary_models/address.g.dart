// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Address',
      json,
      ($checkedConvert) {
        final val = Address(
          streetName: $checkedConvert('streetName', (v) => v as String?),
          streetNumber: $checkedConvert('streetNumber', (v) => v as String?),
          zipCode: $checkedConvert('zipCode', (v) => v as String?),
          city: $checkedConvert('city', (v) => v as String?),
          state: $checkedConvert('state', (v) => v as String?),
          country: $checkedConvert('country', (v) => v as String?),
          creationDate: $checkedConvert('creationDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
          modifiedDates: $checkedConvert(
              'modifiedDates',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => DateTime.parse(e as String))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'streetName': instance.streetName,
      'streetNumber': instance.streetNumber,
      'zipCode': instance.zipCode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'creationDate': instance.creationDate?.toIso8601String(),
      'modifiedDates':
          instance.modifiedDates?.map((e) => e.toIso8601String()).toList(),
    };
