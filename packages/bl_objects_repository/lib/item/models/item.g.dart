// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      userId: json['userId'] as String?,
      id: json['id'] as String?,
      title: json['title'] as String,
      pricePerUnit: (json['pricePerUnit'] as num?)?.toDouble(),
      description: json['description'] as String?,
      tax: (json['tax'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'pricePerUnit': instance.pricePerUnit,
      'description': instance.description,
      'tax': instance.tax,
      'discount': instance.discount,
    };
