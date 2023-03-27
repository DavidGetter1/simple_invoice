import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/items/models/itemDTO.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item extends Equatable {
  const Item(
      {this.userId,
      this.id,
      required this.title,
      this.pricePerUnit,
      this.description,
      this.tax,
      this.discount});
  final String? userId;
  final String? id;
  final String title;
  final double? pricePerUnit;
  final String? description;
  final double? tax;
  final double? discount;

  factory Item.fromItemDTO(ItemDTO itemDTO) {
    return Item(
        userId: itemDTO.userId,
        id: itemDTO.id,
        title: itemDTO.title,
        pricePerUnit: itemDTO.pricePerUnit,
        description: itemDTO.description,
        tax: itemDTO.tax,
        discount: itemDTO.discount);
  }

  ItemDTO toItemDTO() {
    return ItemDTO(
        userId: userId,
        id: id,
        title: title,
        pricePerUnit: pricePerUnit,
        description: description,
        tax: tax,
        discount: discount);
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item copyWth(
      {String? userId,
      String? id,
      String? title,
      double? pricePerUnit,
      String? description,
      double? tax,
      double? discount,
      bool? taxIncluded,
      double? taxedAmount}) {
    return Item(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        pricePerUnit: pricePerUnit ?? this.pricePerUnit,
        description: description ?? this.description,
        tax: tax ?? this.tax,
        discount: discount ?? this.discount);
  }

  @override
  List<Object?> get props =>
      [userId, id, title, pricePerUnit, description, tax, discount];
}
