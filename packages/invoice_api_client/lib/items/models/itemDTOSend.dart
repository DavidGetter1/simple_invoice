import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'itemDTOSend.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemDTOSend extends Equatable{
  const ItemDTOSend( {
    required this.userId,
    required this.title,
    required this.pricePerUnit,
    required this.description,
    required this.tax,
    required this.discount,
    required this.taxIncluded,
    this.taxedAmount,
  });
  final String userId;
  final String title;
  final double pricePerUnit;
  final String description;
  final double tax;
  final double discount;
  final bool taxIncluded;
  final double? taxedAmount;

  factory ItemDTOSend.fromJson(Map<String, dynamic> json) =>
      _$ItemDTOSendFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDTOSendToJson(this);

  ItemDTOSend copyWth({
    String? userId,
    String? title,
    double? pricePerUnit,
    String? description,
    double? tax,
    double? discount,
    bool? taxIncluded,
    double? taxedAmount
  }){
    return ItemDTOSend(
        userId: userId ?? this.userId,
        title: title ?? this.title,
        pricePerUnit: pricePerUnit ?? this.pricePerUnit,
        description: description ?? this.description,
        tax: tax ?? this.tax,
        discount: discount ?? this.discount,
        taxIncluded: taxIncluded ?? this.taxIncluded,
        taxedAmount: taxedAmount ?? this.taxedAmount
    );
  }

  @override
  List<Object?> get props => [userId, title, pricePerUnit, description, taxedAmount, tax, discount, taxIncluded];
}
