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
          id: $checkedConvert('id', (v) => v as String),
          userId: $checkedConvert('userId', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          pricePerUnit:
              $checkedConvert('pricePerUnit', (v) => (v as num?)?.toDouble()),
          description: $checkedConvert('description', (v) => v as String?),
          tax: $checkedConvert('tax', (v) => (v as num?)?.toDouble()),
          discount: $checkedConvert('discount', (v) => (v as num?)?.toDouble()),
          creationDate: $checkedConvert('creationDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
          modifiedDates: $checkedConvert(
              'modifiedDates',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => DateTime.parse(e as String))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'pricePerUnit': instance.pricePerUnit,
      'description': instance.description,
      'tax': instance.tax,
      'discount': instance.discount,
      'creationDate': instance.creationDate?.toIso8601String(),
      'modifiedDates':
          instance.modifiedDates?.map((e) => e.toIso8601String()).toList(),
    };
