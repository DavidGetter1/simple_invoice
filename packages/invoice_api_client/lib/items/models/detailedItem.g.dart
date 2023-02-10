// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'detailedItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailedItem _$DetailedItemFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DetailedItem',
      json,
      ($checkedConvert) {
        final val = DetailedItem(
          quantity: $checkedConvert('quantity', (v) => (v as num).toDouble()),
          quantityIdentifier:
              $checkedConvert('quantityIdentifier', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
          item: $checkedConvert(
              'item',
              (v) =>
                  v == null ? null : Item.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$DetailedItemToJson(DetailedItem instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'quantityIdentifier': instance.quantityIdentifier,
      'id': instance.id,
      'item': instance.item?.toJson(),
    };
