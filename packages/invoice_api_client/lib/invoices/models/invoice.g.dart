// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Invoice',
      json,
      ($checkedConvert) {
        final val = Invoice(
          userId: $checkedConvert('userId', (v) => v as String),
          clientId: $checkedConvert('clientId', (v) => v as String),
          discount: $checkedConvert('discount', (v) => (v as num).toDouble()),
          paymentInformation: $checkedConvert('paymentInformation',
              (v) => PaymentInformation.fromJson(v as Map<String, dynamic>)),
          itemList: $checkedConvert(
              'itemList',
              (v) => (v as List<dynamic>)
                  .map((e) => DetailedItem.fromJson(e as Map<String, dynamic>))
                  .toList()),
          isPaid: $checkedConvert('isPaid', (v) => v as bool),
          paymentAfterTaxAndDiscount: $checkedConvert(
              'paymentAfterTaxAndDiscount', (v) => (v as num).toDouble()),
          paymentDate: $checkedConvert(
              'paymentDate', (v) => DateTime.parse(v as String)),
          creationDate: $checkedConvert(
              'creationDate', (v) => DateTime.parse(v as String)),
          deliveryDate: $checkedConvert(
              'deliveryDate', (v) => DateTime.parse(v as String)),
          invoiceNumber: $checkedConvert('invoiceNumber', (v) => v as String),
          modifiedDate: $checkedConvert(
              'modifiedDate', (v) => DateTime.parse(v as String)),
          id: $checkedConvert('id', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'clientId': instance.clientId,
      'invoiceNumber': instance.invoiceNumber,
      'isPaid': instance.isPaid,
      'discount': instance.discount,
      'paymentAfterTaxAndDiscount': instance.paymentAfterTaxAndDiscount,
      'itemList': instance.itemList.map((e) => e.toJson()).toList(),
      'paymentInformation': instance.paymentInformation.toJson(),
      'creationDate': instance.creationDate.toIso8601String(),
      'paymentDate': instance.paymentDate.toIso8601String(),
      'deliveryDate': instance.deliveryDate.toIso8601String(),
      'modifiedDate': instance.modifiedDate.toIso8601String(),
    };
