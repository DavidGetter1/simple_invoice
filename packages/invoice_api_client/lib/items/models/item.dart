import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item extends Equatable{
  const Item( {
    required this.userId,
    required this.id,
    required this.title,
    required this.pricePerUnit,
    required this.description,
    required this.tax,
    required this.discount,
    required this.taxIncluded,
    required this.creationDate,
    required this.modifiedDate,
    this.taxedAmount,
});
  final String userId;
  final String id;
  final String title;
  final double pricePerUnit;
  final String description;
  final double tax;
  final double discount;
  final bool taxIncluded;
  final DateTime creationDate;
  final DateTime modifiedDate;
  final double? taxedAmount;

  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item copyWth({
    String? userId,
    String? id,
    String? title,
    double? pricePerUnit,
    String? description,
    double? tax,
    double? discount,
    bool? taxIncluded,
    DateTime? creationDate,
    DateTime? modifiedDate,
    double? taxedAmount
  }){
  return Item(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      description: description ?? this.description,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      taxIncluded: taxIncluded ?? this.taxIncluded,
      modifiedDate: this.modifiedDate,
      creationDate: this.creationDate,
      taxedAmount: taxedAmount ?? this.taxedAmount
  );
}

  @override
  List<Object?> get props => [userId, id, title, pricePerUnit, description, taxedAmount, tax, discount, taxIncluded, creationDate, modifiedDate];
}
