import 'package:invoice_api_client/invoices/invoice_api_client.dart';
import 'package:invoice_api_client/invoices/models/invoice.dart';

import '../repository/repository.dart';

/// Repository for [Invoice]s.
/// Injecting APiClient for testing purposes
class InvoiceRepository extends Repository<Invoice> {
  InvoiceRepository(InvoiceApiClient? itemApiClient)
      : super(apiClient: InvoiceApiClient());
}
