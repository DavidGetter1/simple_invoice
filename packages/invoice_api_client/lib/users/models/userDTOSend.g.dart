// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'userDTOSend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTOSend _$UserDTOSendFromJson(Map<String, dynamic> json) => $checkedCreate(
      'UserDTOSend',
      json,
      ($checkedConvert) {
        final val = UserDTOSend(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          billingInformation: $checkedConvert('billingInformation',
              (v) => BillingInformation.fromJson(v as Map<String, dynamic>)),
          locale:
              $checkedConvert('locale', (v) => $enumDecode(_$LocaleEnumMap, v)),
          email: $checkedConvert('email', (v) => v as String),
          hasPremium: $checkedConvert('hasPremium', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$UserDTOSendToJson(UserDTOSend instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'billingInformation': instance.billingInformation.toJson(),
      'locale': _$LocaleEnumMap[instance.locale]!,
      'email': instance.email,
      'hasPremium': instance.hasPremium,
    };

const _$LocaleEnumMap = {
  Locale.DE: 'DE',
  Locale.EN: 'EN',
  Locale.PL: 'PL',
};
