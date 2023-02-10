import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/src/models/paymentInformation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../invoice_api_client.dart';

part 'invoice.g.dart';

@JsonSerializable(explicitToJson: true)
class Invoice extends Equatable {
  final String id;
  final String userId;
  final String clientId;
  final String invoiceNumber;
  final bool isPaid;
  final double discount;
  final double paymentAfterTaxAndDiscount;
  final List<DetailedItem> itemList;
  final PaymentInformation paymentInformation;
  final DateTime creationDate;
  final DateTime paymentDate;
  final DateTime deliveryDate;
  final DateTime modifiedDate;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  Invoice({
    required this.userId,
    required this.clientId,
    required this.discount,
    required this.paymentInformation,
    required this.itemList,
    required this.isPaid,
    required this.paymentAfterTaxAndDiscount,
    required this.paymentDate,
    required this.creationDate,
    required this.deliveryDate,
    required this.invoiceNumber,
    required this.modifiedDate,
    required this.id
  });

  Invoice copyWth({
    String? userId,
    String? id,
    String? clientId,
    double? discount,
    PaymentInformation? paymentInformation,
    List<DetailedItem>? itemList,
    bool? isPaid,
    double? paymentAfterTaxAndDiscount,
    DateTime? creationDate,
    DateTime? modifiedDate,
    DateTime? paymentDate,
    DateTime? deliveryDate,
    String? invoiceNumber
  }){
    return Invoice(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        creationDate: this.creationDate,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        paymentDate: paymentDate ?? this.paymentDate,
        paymentInformation: paymentInformation ?? this.paymentInformation,
        paymentAfterTaxAndDiscount: paymentAfterTaxAndDiscount ?? this.paymentAfterTaxAndDiscount,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        clientId: clientId ?? this.clientId,
        discount: discount ?? this.discount,
        isPaid: isPaid ?? this.isPaid,
        itemList: itemList ?? this.itemList
    );
  }
  @override
  List<Object?> get props => [userId, id, deliveryDate, invoiceNumber, clientId, itemList, paymentDate, paymentInformation, paymentAfterTaxAndDiscount, isPaid, discount, modifiedDate, creationDate, id];
}