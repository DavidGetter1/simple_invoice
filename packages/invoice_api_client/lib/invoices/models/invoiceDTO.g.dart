// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'invoiceDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceDTO _$InvoiceDTOFromJson(Map<String, dynamic> json) => $checkedCreate(
      'InvoiceDTO',
      json,
      ($checkedConvert) {
        final val = InvoiceDTO(
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
          isPaid: $checkedConvert('isPaid', (v) => v as bool?),
          paymentAfterTaxAndDiscount: $checkedConvert(
              'paymentAfterTaxAndDiscount', (v) => (v as num?)?.toDouble()),
          paymentDate: $checkedConvert('paymentDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
          creationDate: $checkedConvert('creationDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
          deliveryDate: $checkedConvert('deliveryDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
          invoiceNumber: $checkedConvert('invoiceNumber', (v) => v as String),
          modifiedDates: $checkedConvert(
              'modifiedDates',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => DateTime.parse(e as String))
                  .toList()),
          overdueDate: $checkedConvert(
              'overdueDate', (v) => DateTime.parse(v as String)),
          reminderDates: $checkedConvert(
              'reminderDates',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => DateTime.parse(e as String))
                  .toList()),
          isDraft: $checkedConvert('isDraft', (v) => v as bool),
          isOverdue: $checkedConvert('isOverdue', (v) => v as bool?),
          nameIssuer: $checkedConvert('nameIssuer', (v) => v as String),
          addressIssuer: $checkedConvert('addressIssuer',
              (v) => Address.fromJson(v as Map<String, dynamic>)),
          nameReceiver: $checkedConvert('nameReceiver', (v) => v as String),
          addressReceiver: $checkedConvert('addressReceiver',
              (v) => Address.fromJson(v as Map<String, dynamic>)),
          issuedDate: $checkedConvert('issuedDate',
              (v) => v == null ? null : DateTime.parse(v as String)),
          ustId: $checkedConvert('ustId', (v) => v as String),
          taxId: $checkedConvert('taxId', (v) => v as String),
          taxExemptionReason:
              $checkedConvert('taxExemptionReason', (v) => v as String),
          legalForm: $checkedConvert(
              'legalForm', (v) => $enumDecode(_$LegalFormEnumMap, v)),
          registryCourt: $checkedConvert('registryCourt', (v) => v as String),
          registryNumber: $checkedConvert('registryNumber', (v) => v as String),
          id: $checkedConvert('id', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$InvoiceDTOToJson(InvoiceDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'clientId': instance.clientId,
      'nameReceiver': instance.nameReceiver,
      'addressReceiver': instance.addressReceiver.toJson(),
      'nameIssuer': instance.nameIssuer,
      'addressIssuer': instance.addressIssuer.toJson(),
      'issuedDate': instance.issuedDate?.toIso8601String(),
      'ustId': instance.ustId,
      'taxId': instance.taxId,
      'invoiceNumber': instance.invoiceNumber,
      'paymentInformation': instance.paymentInformation.toJson(),
      'itemList': instance.itemList.map((e) => e.toJson()).toList(),
      'paymentAfterTaxAndDiscount': instance.paymentAfterTaxAndDiscount,
      'discount': instance.discount,
      'taxExemptionReason': instance.taxExemptionReason,
      'legalForm': _$LegalFormEnumMap[instance.legalForm]!,
      'registryCourt': instance.registryCourt,
      'registryNumber': instance.registryNumber,
      'isPaid': instance.isPaid,
      'isDraft': instance.isDraft,
      'isOverdue': instance.isOverdue,
      'reminderDates':
          instance.reminderDates?.map((e) => e.toIso8601String()).toList(),
      'overdueDate': instance.overdueDate.toIso8601String(),
      'creationDate': instance.creationDate?.toIso8601String(),
      'paymentDate': instance.paymentDate?.toIso8601String(),
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'modifiedDates':
          instance.modifiedDates?.map((e) => e.toIso8601String()).toList(),
    };

const _$LegalFormEnumMap = {
  LegalForm.GbR: 'GbR',
  LegalForm.GmbH: 'GmbH',
  LegalForm.AG: 'AG',
  LegalForm.UG: 'UG',
  LegalForm.OHG: 'OHG',
  LegalForm.KG: 'KG',
  LegalForm.eK: 'eK',
  LegalForm.eG: 'eG',
  LegalForm.GmbHCoKG: 'GmbHCoKG',
  LegalForm.GmbHCoOHG: 'GmbHCoOHG',
  LegalForm.GmbHCoKGaA: 'GmbHCoKGaA',
};
