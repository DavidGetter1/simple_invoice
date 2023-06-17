import 'package:equatable/equatable.dart';
import 'package:invoice_api_client/invoice_api_client.dart';

class InvoiceResponse extends Equatable {
  final List<Invoice> invoiceList;
  final int lastN;
  InvoiceResponse({required this.invoiceList, required this.lastN});

  @override
  List<Object?> get props => [invoiceList, lastN];
}
