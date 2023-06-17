import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/complementary_models/paymentInformation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../invoice_api_client.dart';

part 'billingInformation.g.dart';

@JsonSerializable(explicitToJson: true)
class BillingInformation extends Equatable {
  final String taxNumber;
  final String germanUstId;
  final String streetName;
  final String streetNumber;
  final String postalCode;
  final String city;
  final String phoneNumber;
  final PaymentInformation? paymentInformation;

  factory BillingInformation.fromJson(Map<String, dynamic> json) =>
      _$BillingInformationFromJson(json);

  Map<String, dynamic> toJson() => _$BillingInformationToJson(this);

  BillingInformation.empty({
    this.taxNumber = "",
    this.germanUstId = "",
    this.streetName = "",
    this.streetNumber = "",
    this.postalCode = "",
    this.city = "",
    this.phoneNumber = "",
    this.paymentInformation = null,
  });

  BillingInformation(
      {required this.taxNumber,
      required this.germanUstId,
      required this.streetName,
      required this.paymentInformation,
      required this.streetNumber,
      required this.postalCode,
      required this.city,
      required this.phoneNumber});

  BillingInformation copyWth(
      {String? taxNumber,
      String? streetNumber,
      String? streetName,
      String? city,
      String? postalCode,
      String? phoneNumber,
      PaymentInformation? paymentInformation,
      String? germanUstId}) {
    return BillingInformation(
        taxNumber: taxNumber ?? this.taxNumber,
        germanUstId: germanUstId ?? this.germanUstId,
        paymentInformation: paymentInformation ?? this.paymentInformation,
        streetName: streetName ?? this.streetName,
        postalCode: postalCode ?? this.postalCode,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        city: city ?? this.city,
        streetNumber: streetNumber ?? this.streetNumber);
  }

  @override
  List<Object?> get props => [
        taxNumber,
        germanUstId,
        streetName,
        paymentInformation,
        streetNumber,
        postalCode,
        phoneNumber,
        city
      ];
}
