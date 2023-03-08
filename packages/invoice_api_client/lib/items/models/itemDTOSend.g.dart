// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'itemDTOSend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemDTOSend _$ItemDTOSendFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ItemDTOSend',
      json,
      ($checkedConvert) {
        final val = ItemDTOSend(
          userId: $checkedConvert('userId', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          pricePerUnit:
              $checkedConvert('pricePerUnit', (v) => (v as num).toDouble()),
          description: $checkedConvert('description', (v) => v as String),
          tax: $checkedConvert('tax', (v) => (v as num).toDouble()),
          discount: $checkedConvert('discount', (v) => (v as num).toDouble()),
          taxIncluded: $checkedConvert('taxIncluded', (v) => v as bool),
          taxedAmount:
              $checkedConvert('taxedAmount', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ItemDTOSendToJson(ItemDTOSend instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
      'pricePerUnit': instance.pricePerUnit,
      'description': instance.description,
      'tax': instance.tax,
      'discount': instance.discount,
      'taxIncluded': instance.taxIncluded,
      'taxedAmount': instance.taxedAmount,
    };
