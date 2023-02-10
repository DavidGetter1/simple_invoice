// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userDTOSend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTOSend _$UserDTOFromJson(Map<String, dynamic> json) => UserDTOSend(
      id: json['id'] as String,
      name: json['name'] as String,
      billingInformation: BillingInformation.fromJson(
          json['billingInformation'] as Map<String, dynamic>),
      locale: $enumDecode(_$LocaleEnumMap, json['locale']),
      email: json['email'] as String,
      hasPremium: json['hasPremium'] as bool,
    );

Map<String, dynamic> _$UserDTOToJson(UserDTOSend instance) => <String, dynamic>{
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
