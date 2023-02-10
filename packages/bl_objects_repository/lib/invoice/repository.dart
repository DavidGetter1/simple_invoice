import 'dart:async';

import 'package:invoice_api_client/invoice_api_client.dart';

import 'models/invoiceResponse.dart';

class InvoiceFailure implements Exception {}

class InvoiceRepository {
  InvoiceRepository({InvoiceApiClient? invoiceApiClient})
      : _invoiceApiClient = invoiceApiClient ?? InvoiceApiClient();

  final InvoiceApiClient _invoiceApiClient;

  Future<Invoice> getInvoice(String id) async{
    Invoice invoice = await _invoiceApiClient.getInvoiceById(id);
    return invoice;
  }

  Future<InvoiceResponse> getInvoices(Map<String, String> query) async{
    Map<String, dynamic> responseMap = await _invoiceApiClient.getInvoices(query);
    InvoiceResponse invoiceResponse = InvoiceResponse(invoiceList: responseMap["invoiceList"], lastN: responseMap["lastN"]);
    return invoiceResponse;
  }

  deleteInvoice(String id) async{
    await _invoiceApiClient.deleteInvoice(id);
  }

  Future<String> insertInvoice(Invoice invoice) async{
    String insertedId = await _invoiceApiClient.insertInvoice(invoice);
    return insertedId;
  }

  updateInvoice(Invoice invoice) async{
    await _invoiceApiClient.updateInvoice(invoice);
  }
}