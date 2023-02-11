import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:invoice_api_client/users/models/userDTOSend.dart';

class User extends Equatable{
  final String id;
  final String name;
  final BillingInformation billingInformation;
  final Locale locale;
  final String email;
  final bool hasPremium;

  User({
    required this.id,
    required this.name,
    required this.billingInformation,
    required this.locale,
    required this.email,
    required this.hasPremium,
  });

  factory User.fromUserDTOReceive(UserDTOReceive user){
    return User(id: user.id, name: user.name, billingInformation: user.billingInformation, locale: user.locale, email: user.email, hasPremium: user.hasPremium ?? false);
  }

  factory User.fromUserDTOSend(UserDTOSend user){
    return User(id: user.id, name: user.name, billingInformation: user.billingInformation, locale: user.locale, email: user.email, hasPremium: user.hasPremium);
  }

  toJson() => {
    'id': id,
    'name': name,
    'billingInformation': billingInformation.toJson(),
    'locale': _$LocaleEnumMap[locale]!,
    'email': email,
    'hasPremium': hasPremium
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      billingInformation: BillingInformation.fromJson(json['billingInformation'] as Map<String, dynamic>),
      locale: Locale.values.firstWhere((locale) => locale.toString().split('.').last == json['locale'] as String),
      email: json['email'] as String,
      hasPremium: json['hasPremium'] as bool,
    );
  }

  final _$LocaleEnumMap = {
  Locale.DE: 'DE',
  Locale.EN: 'EN',
  Locale.PL: 'PL',
};

  UserDTOSend toDTOSend(){
    return UserDTOSend(
      id: id,
      name: name,
      billingInformation: billingInformation,
      locale: locale,
      email: email,
      hasPremium: hasPremium
    );
  }

  @override
  List<Object?> get props => [billingInformation, email, hasPremium, locale, name];
}