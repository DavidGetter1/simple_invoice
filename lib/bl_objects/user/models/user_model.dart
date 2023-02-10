import 'package:flutter/material.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:invoice_api_client/users/models/userDTOSend.dart';

class User {
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

  factory User.fromUserDTOSend(UserDTOSend user){
    return User(id: user.id, name: user.name, billingInformation: user.billingInformation, locale: user.locale, email: user.email, hasPremium: user.hasPremium);
  }

  userToDTOSend(){
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