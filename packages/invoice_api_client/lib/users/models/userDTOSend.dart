import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:json_annotation/json_annotation.dart';

part 'userDTOSend.g.dart';

@JsonSerializable(explicitToJson: true)
class UserDTOSend extends Equatable {
  final String id;
  final String name;
  final BillingInformation billingInformation;
  final Locale locale;
  final String email;
  final bool hasPremium;

  UserDTOSend({
    required this.id,
    required this.name,
    required this.billingInformation,
    required this.locale,
    required this.email,
    required this.hasPremium,
  });


  factory UserDTOSend.fromJson(Map<String, dynamic> json) =>
      _$UserDTOSendFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOSendToJson(this);

  @override
  List<Object?> get props => [billingInformation, email, hasPremium, locale, name];
}