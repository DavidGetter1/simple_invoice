// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String?,
      billingInformation: json['billingInformation'] == null
          ? null
          : BillingInformation.fromJson(
              json['billingInformation'] as Map<String, dynamic>),
      locale: $enumDecodeNullable(_$LocaleEnumMap, json['locale']),
      email: json['email'] as String?,
      hasPremium: json['hasPremium'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'billingInformation': instance.billingInformation?.toJson(),
      'locale': _$LocaleEnumMap[instance.locale],
      'email': instance.email,
      'hasPremium': instance.hasPremium,
    };

const _$LocaleEnumMap = {
  Locale.DE: 'DE',
  Locale.EN: 'EN',
  Locale.PL: 'PL',
};
