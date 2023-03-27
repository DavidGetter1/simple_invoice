// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'itemDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDTO _$ItemDTOFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ItemDTO',
      json,
      ($checkedConvert) {
        final val = ItemDTO(
          userId: $checkedConvert('userId', (v) => v as String?),
          id: $checkedConvert('id', (v) => v as String?),
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

Map<String, dynamic> _$ItemDTOToJson(ItemDTO instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'pricePerUnit': instance.pricePerUnit,
      'description': instance.description,
      'tax': instance.tax,
      'discount': instance.discount,
      'creationDate': instance.creationDate?.toIso8601String(),
      'modifiedDates':
          instance.modifiedDates?.map((e) => e.toIso8601String()).toList(),
    };
