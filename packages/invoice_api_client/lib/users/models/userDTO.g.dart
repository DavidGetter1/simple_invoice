// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'userDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UserDTO',
      json,
      ($checkedConvert) {
        final val = UserDTO(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String?),
          billingInformation: $checkedConvert(
              'billingInformation',
              (v) => v == null
                  ? null
                  : BillingInformation.fromJson(v as Map<String, dynamic>)),
          locale: $checkedConvert(
              'locale', (v) => $enumDecodeNullable(_$LocaleEnumMap, v)),
          email: $checkedConvert('email', (v) => v as String?),
          creationDate: $checkedConvert('creationDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
          purchaseToken: $checkedConvert('purchaseToken',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          hasPremium: $checkedConvert('hasPremium', (v) => v as bool?),
          originalTransactionId:
              $checkedConvert('originalTransactionId', (v) => v as String?),
          subscriptionExpirationDate: $checkedConvert(
              'subscriptionExpirationDate',
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

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'billingInformation': instance.billingInformation?.toJson(),
      'locale': _$LocaleEnumMap[instance.locale],
      'email': instance.email,
      'purchaseToken': instance.purchaseToken,
      'hasPremium': instance.hasPremium,
      'creationDate': instance.creationDate?.toIso8601String(),
      'modifiedDates':
          instance.modifiedDates?.map((e) => e.toIso8601String()).toList(),
      'originalTransactionId': instance.originalTransactionId,
      'subscriptionExpirationDate':
          instance.subscriptionExpirationDate?.toIso8601String(),
    };

const _$LocaleEnumMap = {
  Locale.DE: 'DE',
  Locale.EN: 'EN',
  Locale.PL: 'PL',
};
