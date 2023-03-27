import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invoice_api_client/invoice_api_client.dart';

class InvoiceIdRequestFailure implements Exception {
  String message;
  InvoiceIdRequestFailure(this.message);
}

class InvoiceApiClient {
  InvoiceApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  // If you want to test it locally, then the _baseUrl is = 'localhost:5001' for example
  // otherwise for deployment its us-central1-invoice-c63dc.cloudfunctions.net
  // also if you doing it locally, change the Uri.https to http if needed.
  // the path looks like this then: '/invoice-c63dc/us-central1/ms_bl_objects/v1/bl_objects/invoice
  // when deploying its simply '/api/v1/bl_objects/invoice'
  // dont forget to adjust http correctly
  static const _baseUrl = 'us-central1-invoice-c63dc.cloudfunctions.net';
  final http.Client _httpClient;

  /**
   * Deletes an [Invoice] by ID.
   */
  deleteInvoice(String id) async {
    final invoiceRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/invoice/$id',
    );
    final invoiceResponse = await _httpClient.delete(invoiceRequest);
    print(invoiceResponse.body);
    if (invoiceResponse.statusCode != 200) {
      throw Exception(invoiceResponse.body);
    }

    final invoiceJson = jsonDecode(invoiceResponse.body);

    if (invoiceJson["deletedCount"] != 1) {
      throw new Exception('No invoices deleted');
    }
  }

  /**
   * Fetches an [Invoice] by ID.
   */
  dynamic getInvoiceById(String id) async {
    print("fetching");
    final invoiceRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/invoice/$id',
    );
    final invoiceResponse = await _httpClient.get(invoiceRequest);

    if (invoiceResponse.statusCode != 200) {
      throw InvoiceIdRequestFailure(invoiceResponse.body.toString());
    }

    final invoiceJson = jsonDecode(invoiceResponse.body);

    if (invoiceJson == {}) {
      throw new Exception('No invoices found');
    }

    try {
      InvoiceDTO invoice =
          InvoiceDTO.fromJson(invoiceJson as Map<String, dynamic>);
      return invoice;
    } catch (e) {
      print(e.toString());
    }
  }

  /**
   * Queries the DB for invoices.
   */
  dynamic getInvoices(Map<String, String> query) async {
    jsonEncode(query);
    final invoiceRequest =
        Uri.https(_baseUrl, '/api/v1/bl_objects/invoice', query);
    final invoiceResponse = await _httpClient.get(invoiceRequest);
    if (invoiceResponse.statusCode != 200) {
      throw new Exception(invoiceResponse.body);
    }

    final invoiceJson = jsonDecode(invoiceResponse.body);
    if (invoiceJson["data"].isEmpty) {
      throw new Exception('No invoices found');
    }
    try {
      List<InvoiceDTO> invoiceList = List<InvoiceDTO>.from(invoiceJson["data"]
          .map((invoice) => InvoiceDTO.fromJson(invoice))
          .toList());
      return {"invoiceList": invoiceList, "lastN": invoiceJson["lastN"]};
    } catch (e) {
      print(e.toString());
    }
  }

  /**
   * Inserts the [Invoice] into the DB.
   */
  insertInvoice(InvoiceDTO invoice) async {
    final invoiceRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/invoice',
    );
    String invoiceJson = jsonEncode(invoice.toJson());
    final invoiceResponse = await _httpClient.put(invoiceRequest,
        body: invoiceJson, headers: {"Content-Type": "application/json"});
    print(invoiceResponse.body);
    if (invoiceResponse.statusCode != 201) {
      throw Exception(invoiceResponse.body);
    }
    final decodedResponse = jsonDecode(invoiceResponse.body);
    return decodedResponse["upsertedId"];
  }

  /**
   * Inserts the [Invoice] into the DB.
   */
  updateInvoice(InvoiceDTO invoice) async {
    final invoiceRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/invoice',
    );
    String invoiceJson = jsonEncode(invoice.toJson());
    final invoiceResponse = await _httpClient.put(invoiceRequest,
        body: invoiceJson, headers: {"Content-Type": "application/json"});
    if (invoiceResponse.statusCode != 200) {
      throw Exception(invoiceResponse.body);
    }

    final responseJson = jsonDecode(invoiceResponse.body);
    final bool updated = responseJson["modifiedCount"] == 1;
    if (!updated) {
      throw new Exception('No invoices updated');
    }
  }
}
