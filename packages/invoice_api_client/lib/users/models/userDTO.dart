import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../src/models/billingInformation.dart';
import 'dart:io';
part 'userDTO.g.dart';

enum Locale { DE, EN, PL }

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
class UserDTO extends Equatable {
  const UserDTO({
    required this.id,
    this.name,
    this.billingInformation,
    this.locale,
    this.email,
    this.creationDate,
    this.purchaseToken,
    this.hasPremium,
    this.originalTransactionId,
    this.subscriptionExpirationDate,
    this.modifiedDates,
  });
  final String id;
  final String? name;
  final BillingInformation? billingInformation;
  final Locale? locale;
  final String? email;
  final List<String>? purchaseToken;
  final bool? hasPremium;
  final DateTime? creationDate;
  final List<DateTime>? modifiedDates;
  final String? originalTransactionId;
  final DateTime? subscriptionExpirationDate;

  factory UserDTO.fromFirebaseUser(UserDTO user) {
    return UserDTO(
        hasPremium: false,
        locale: stringToLocale(Platform.localeName),
        originalTransactionId: '',
        name: '',
        billingInformation: BillingInformation.empty(),
        modifiedDates: null,
        email: '',
        creationDate: null,
        purchaseToken: [],
        id: '',
        subscriptionExpirationDate: null);
  }

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  UserDTO copyWth(
      {String? id,
      String? name,
      BillingInformation? billingInformation,
      Locale? locale,
      String? email,
      List<String>? purchaseToken,
      bool? hasPremium,
      DateTime? creationDate,
      DateTime? modifiedDate,
      String? originalTransactionId,
      DateTime? subscriptionExpirationDate}) {
    return UserDTO(
        modifiedDates: modifiedDates ?? this.modifiedDates,
        creationDate: creationDate ?? this.creationDate,
        hasPremium: hasPremium ?? this.hasPremium,
        locale: locale ?? this.locale,
        subscriptionExpirationDate:
            subscriptionExpirationDate ?? this.subscriptionExpirationDate,
        purchaseToken: purchaseToken ?? this.purchaseToken,
        name: name ?? this.name,
        billingInformation: billingInformation ?? this.billingInformation,
        originalTransactionId:
            originalTransactionId ?? this.originalTransactionId,
        email: email ?? this.email,
        id: id ?? this.id);
  }

  @override
  List<Object?> get props => [
        billingInformation,
        originalTransactionId,
        email,
        hasPremium,
        locale,
        subscriptionExpirationDate,
        purchaseToken,
        name,
        creationDate,
        modifiedDates
      ];
}
