import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'item.dart';
part 'detailedItem.g.dart';

@JsonSerializable(explicitToJson: true)
class DetailedItem extends Equatable {
  const DetailedItem( {
    required this.quantity,
    required this.quantityIdentifier,
    required this.id,
    this.item,
  });
  final double quantity;
  final String quantityIdentifier;
  final String id;
  final Item? item;

  factory DetailedItem.fromJson(Map<String, dynamic> json) =>
      _$DetailedItemFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedItemToJson(this);

  DetailedItem copyWth({
    double? quantity,
    String? quantityIdentifier,
    String? id,
    Item? item
  }){
    return DetailedItem(
        quantity: quantity ?? this.quantity,
        id: id ?? this.id,
        quantityIdentifier: quantityIdentifier ?? this.quantityIdentifier,
        item: item ?? this.item
    );
  }

  @override
  List<Object?> get props => [quantity, id, quantityIdentifier, item];
}