import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'itemDTO.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemDTO extends Equatable {
  const ItemDTO({
    this.userId,
    this.id,
    required this.title,
    this.pricePerUnit,
    this.description,
    this.tax,
    this.discount,
    this.creationDate,
    this.modifiedDates,
  });
  final String? userId;
  final String? id;
  final String title;
  final double? pricePerUnit;
  final String? description;
  final double? tax;
  final double? discount;
  final DateTime? creationDate;
  final List<DateTime>? modifiedDates;

  factory ItemDTO.fromJson(Map<String, dynamic> json) =>
      _$ItemDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDTOToJson(this);

  ItemDTO copyWth(
      {String? userId,
      String? id,
      String? title,
      double? pricePerUnit,
      String? description,
      double? tax,
      double? discount,
      DateTime? creationDate,
      DateTime? modifiedDate}) {
    return ItemDTO(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        pricePerUnit: pricePerUnit ?? this.pricePerUnit,
        description: description ?? this.description,
        tax: tax ?? this.tax,
        discount: discount ?? this.discount,
        modifiedDates: this.modifiedDates,
        creationDate: this.creationDate);
  }

  @override
  List<Object?> get props => [
        userId,
        id,
        title,
        pricePerUnit,
        description,
        tax,
        discount,
        creationDate,
        modifiedDates
      ];
}
