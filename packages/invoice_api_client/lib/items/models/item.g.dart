// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Item',
      json,
      ($checkedConvert) {
        final val = Item(
          userId: $checkedConvert('userId', (v) => v as String),
          id: $checkedConvert('_id', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          pricePerUnit:
              $checkedConvert('pricePerUnit', (v) => (v as num).toDouble()),
          description: $checkedConvert('description', (v) => v as String),
          tax: $checkedConvert('tax', (v) => (v as num).toDouble()),
          discount: $checkedConvert('discount', (v) => (v as num).toDouble()),
          taxIncluded: $checkedConvert('taxIncluded', (v) => v as bool),
          creationDate: $checkedConvert(
              'creationDate', (v) => DateTime.parse(v as String)),
          modifiedDate: $checkedConvert(
              'modifiedDate', (v) => DateTime.parse(v as String)),
          taxedAmount:
              $checkedConvert('taxedAmount', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'userId': instance.userId,
      '_id': instance.id,
      'title': instance.title,
      'pricePerUnit': instance.pricePerUnit,
      'description': instance.description,
      'tax': instance.tax,
      'discount': instance.discount,
      'taxIncluded': instance.taxIncluded,
      'creationDate': instance.creationDate.toIso8601String(),
      'modifiedDate': instance.modifiedDate.toIso8601String(),
      'taxedAmount': instance.taxedAmount,
    };
