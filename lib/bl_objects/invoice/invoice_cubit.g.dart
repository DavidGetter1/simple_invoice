// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceCreatedState _$InvoiceCreatedStateFromJson(Map<String, dynamic> json) =>
    InvoiceCreatedState(
      id: json['id'] as String,
    );

Map<String, dynamic> _$InvoiceCreatedStateToJson(
        InvoiceCreatedState instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

InvoiceFetchedState _$InvoiceFetchedStateFromJson(Map<String, dynamic> json) =>
    InvoiceFetchedState(
      invoice: Invoice.fromJson(json['invoice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvoiceFetchedStateToJson(
        InvoiceFetchedState instance) =>
    <String, dynamic>{
      'invoice': instance.invoice.toJson(),
    };

InvoiceListFetchedState _$InvoiceListFetchedStateFromJson(
        Map<String, dynamic> json) =>
    InvoiceListFetchedState(
      invoiceList: (json['invoiceList'] as List<dynamic>)
          .map((e) => Invoice.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastN: json['lastN'] as int,
    );

Map<String, dynamic> _$InvoiceListFetchedStateToJson(
        InvoiceListFetchedState instance) =>
    <String, dynamic>{
      'lastN': instance.lastN,
      'invoiceList': instance.invoiceList.map((e) => e.toJson()).toList(),
    };

FailureState _$FailureStateFromJson(Map<String, dynamic> json) => FailureState(
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$FailureStateToJson(FailureState instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
    };
