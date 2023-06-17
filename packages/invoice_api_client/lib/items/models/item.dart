import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/task/serializable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../entity/entity.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item extends Entity implements Serializable {
  Item({
    required this.id,
    required this.userId,
    required this.title,
    this.pricePerUnit,
    this.description,
    this.tax,
    this.discount,
    this.creationDate,
    this.modifiedDates,
  }) : super(id: id, userId: userId);
  String id;
  String userId;
  final String title;
  final double? pricePerUnit;
  final String? description;
  final double? tax;
  final double? discount;
  final DateTime? creationDate;
  final List<DateTime>? modifiedDates;

  void setId(String id) {
    this.id = id;
    super.setId(id);
  }

  void setUserId(String userId) {
    this.userId = userId;
    super.setUserId(userId);
  }

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item copyWth(
      {String? id,
      String? userId,
      String? title,
      double? pricePerUnit,
      String? description,
      double? tax,
      double? discount,
      DateTime? creationDate,
      DateTime? modifiedDate}) {
    return Item(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        pricePerUnit: pricePerUnit ?? this.pricePerUnit,
        description: description ?? this.description,
        tax: tax ?? this.tax,
        discount: discount ?? this.discount,
        modifiedDates: this.modifiedDates,
        creationDate: this.creationDate);
  }

  Item updateFrom(Item item) {
    return Item(
        id: item.id ?? this.id,
        userId: item.userId ?? this.userId,
        title: item.title ?? this.title,
        pricePerUnit: item.pricePerUnit ?? this.pricePerUnit,
        description: item.description ?? this.description,
        tax: item.tax ?? this.tax,
        discount: item.discount ?? this.discount,
        modifiedDates: this.modifiedDates,
        creationDate: this.creationDate);
  }

  @override
  List<Object?> get props => [
        title,
        pricePerUnit,
        description,
        tax,
        discount,
        creationDate,
        modifiedDates
      ];
}
