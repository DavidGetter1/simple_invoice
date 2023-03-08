// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'userDTOReceive.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTOReceive _$UserDTOReceiveFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UserDTOReceive',
      json,
      ($checkedConvert) {
        final val = UserDTOReceive(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          billingInformation: $checkedConvert('billingInformation',
              (v) => BillingInformation.fromJson(v as Map<String, dynamic>)),
          locale:
              $checkedConvert('locale', (v) => $enumDecode(_$LocaleEnumMap, v)),
          email: $checkedConvert('email', (v) => v as String),
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
          modifiedDate: $checkedConvert('modifiedDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$UserDTOReceiveToJson(UserDTOReceive instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'billingInformation': instance.billingInformation.toJson(),
      'locale': _$LocaleEnumMap[instance.locale]!,
      'email': instance.email,
      'purchaseToken': instance.purchaseToken,
      'hasPremium': instance.hasPremium,
      'creationDate': instance.creationDate?.toIso8601String(),
      'modifiedDate': instance.modifiedDate?.toIso8601String(),
      'originalTransactionId': instance.originalTransactionId,
      'subscriptionExpirationDate':
          instance.subscriptionExpirationDate?.toIso8601String(),
    };

const _$LocaleEnumMap = {
  Locale.DE: 'DE',
  Locale.EN: 'EN',
  Locale.PL: 'PL',
};
