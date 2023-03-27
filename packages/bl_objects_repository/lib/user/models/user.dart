import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
part 'user.g.dart';

Locale stringToLocale(String localeString) {
  switch (localeString) {
    case 'DE':
      return Locale.DE;
    case 'EN':
      return Locale.EN;
    case 'PL':
      return Locale.PL;
    default:
      throw Exception('Unsupported locale string');
  }
}

@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  const User(
      {required this.id,
      this.name,
      this.billingInformation,
      this.locale,
      this.email,
      this.hasPremium});
  final String id;
  final String? name;
  final BillingInformation? billingInformation;
  final Locale? locale;
  final String? email;
  final bool? hasPremium;

  factory User.fromFirebaseUser(User user) {
    return User(
      hasPremium: false,
      locale: stringToLocale(Platform.localeName),
      name: '',
      billingInformation: BillingInformation.empty(),
      email: '',
      id: '',
    );
  }

  UserDTO toUserDTO() {
    return UserDTO(
        hasPremium: hasPremium,
        locale: locale,
        name: name,
        billingInformation: billingInformation,
        email: email,
        id: id);
  }

  factory User.fromUserDTO(UserDTO user) {
    return User(
        hasPremium: user.hasPremium,
        locale: user.locale,
        name: user.name,
        billingInformation: user.billingInformation,
        email: user.email,
        id: user.id);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWth(
      {String? id,
      String? name,
      BillingInformation? billingInformation,
      Locale? locale,
      String? email,
      bool? hasPremium}) {
    return User(
        hasPremium: hasPremium ?? this.hasPremium,
        locale: locale ?? this.locale,
        name: name ?? this.name,
        billingInformation: billingInformation ?? this.billingInformation,
        email: email ?? this.email,
        id: id ?? this.id);
  }

  @override
  List<Object?> get props =>
      [billingInformation, email, hasPremium, locale, name];
}
