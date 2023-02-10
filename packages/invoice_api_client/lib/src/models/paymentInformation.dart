import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paymentInformation.g.dart';

@JsonSerializable()
class PaymentInformation extends Equatable{
  const PaymentInformation( {
    required this.type,
    required this.details
  });
  final String type;
  final String details;

  factory PaymentInformation.fromJson(Map<String, dynamic> json) =>
      _$PaymentInformationFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInformationToJson(this);

  PaymentInformation copyWth({
    String? type,
    String? details
  }){
    return PaymentInformation(
        type: type ?? this.type,
        details: details ?? this.details
    );
  }

  @override
  List<Object?> get props => [type, details];
}
