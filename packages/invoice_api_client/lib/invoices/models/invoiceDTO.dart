import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/complementary_models/legal_form.dart';
import 'package:invoice_api_client/src/models/paymentInformation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../complementary_models/address.dart';
import '../../invoice_api_client.dart';

part 'invoiceDTO.g.dart';

@JsonSerializable(explicitToJson: true)
class InvoiceDTO extends Equatable {
  final String id;
  final String userId;
  final String clientId;
  final String nameReceiver;
  final Address addressReceiver;
  final String nameIssuer;
  final Address addressIssuer;
  final DateTime? issuedDate;
  final String ustId;
  final String taxId;
  final String invoiceNumber;
  final PaymentInformation paymentInformation;
  final List<DetailedItem> itemList;
  final double? paymentAfterTaxAndDiscount;
  final double discount;
  final String taxExemptionReason;
  final LegalForm legalForm;
  final String registryCourt;
  final String registryNumber;
  final bool? isPaid;
  final bool isDraft;
  final bool? isOverdue;
  final List<DateTime>? reminderDates;
  final DateTime overdueDate;
  final DateTime? creationDate;
  final DateTime? paymentDate;
  final DateTime? deliveryDate;
  final List<DateTime>? modifiedDates;

  factory InvoiceDTO.fromJson(Map<String, dynamic> json) =>
      _$InvoiceDTOFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceDTOToJson(this);

  InvoiceDTO(
      {required this.userId,
      required this.clientId,
      required this.discount,
      required this.paymentInformation,
      required this.itemList,
      this.isPaid,
      this.paymentAfterTaxAndDiscount,
      this.paymentDate,
      this.creationDate,
      this.deliveryDate,
      required this.invoiceNumber,
      this.modifiedDates,
      required this.overdueDate,
      this.reminderDates,
      required this.isDraft,
      this.isOverdue,
      required this.nameIssuer,
      required this.addressIssuer,
      required this.nameReceiver,
      required this.addressReceiver,
      required this.issuedDate,
      required this.ustId,
      required this.taxId,
      required this.taxExemptionReason,
      required this.legalForm,
      required this.registryCourt,
      required this.registryNumber,
      required this.id});

  InvoiceDTO copyWth(
      {String? userId,
      String? id,
      String? clientId,
      double? discount,
      PaymentInformation? paymentInformation,
      List<DetailedItem>? itemList,
      bool? isPaid,
      double? paymentAfterTaxAndDiscount,
      DateTime? paymentDate,
      DateTime? deliveryDate,
      String? invoiceNumber,
      String? nameIssuer,
      Address? addressIssuer,
      String? nameReceiver,
      Address? addressReceiver,
      DateTime? issuedDate,
      String? ustId,
      String? taxId,
      String? taxExemptionReason,
      LegalForm? legalForm,
      String? registryCourt,
      String? registryNumber,
      bool? isDraft,
      bool? isOverdue,
      DateTime? overdueDate}) {
    return InvoiceDTO(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        creationDate: this.creationDate,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        paymentDate: paymentDate ?? this.paymentDate,
        paymentInformation: paymentInformation ?? this.paymentInformation,
        paymentAfterTaxAndDiscount:
            paymentAfterTaxAndDiscount ?? this.paymentAfterTaxAndDiscount,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        clientId: clientId ?? this.clientId,
        discount: discount ?? this.discount,
        isPaid: isPaid ?? this.isPaid,
        itemList: itemList ?? this.itemList,
        nameIssuer: nameIssuer ?? this.nameIssuer,
        addressIssuer: addressIssuer ?? this.addressIssuer,
        nameReceiver: nameReceiver ?? this.nameReceiver,
        addressReceiver: addressReceiver ?? this.addressReceiver,
        issuedDate: issuedDate ?? this.issuedDate,
        ustId: ustId ?? this.ustId,
        taxId: taxId ?? this.taxId,
        taxExemptionReason: taxExemptionReason ?? this.taxExemptionReason,
        legalForm: legalForm ?? this.legalForm,
        registryCourt: registryCourt ?? this.registryCourt,
        registryNumber: registryNumber ?? this.registryNumber,
        isDraft: isDraft ?? this.isDraft,
        isOverdue: isOverdue ?? this.isOverdue,
        overdueDate: overdueDate ?? this.overdueDate);
  }

  @override
  List<Object?> get props => [
        userId,
        id,
        deliveryDate,
        invoiceNumber,
        clientId,
        itemList,
        paymentDate,
        paymentInformation,
        paymentAfterTaxAndDiscount,
        isPaid,
        discount,
        modifiedDates,
        creationDate,
        id
      ];
}
