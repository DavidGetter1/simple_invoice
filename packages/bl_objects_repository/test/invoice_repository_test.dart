// ignore_for_file: prefer_const_constructors
import 'package:invoice_api_client/invoice_api_client.dart' as invoice_api;
import 'package:bl_objects_repository/invoice/index.dart';
import 'package:invoice_api_client/invoices/models/invoice.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockInvoiceApiClient extends Mock
    implements invoice_api.InvoiceApiClient {}

class MockInvoice extends Mock implements invoice_api.Invoice { }
void main() {
  group('InvoiceRepository', () {
    late invoice_api.InvoiceApiClient invoiceApiClient;
    late InvoiceRepository invoiceRepository;

    setUp(() {
      invoiceApiClient = MockInvoiceApiClient();
      invoiceRepository = InvoiceRepository(
        invoiceApiClient: invoiceApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal MetaWeatherApiClient when not injected', () {
        expect(InvoiceRepository(), isNotNull);
      });
    });

    group('deleteInvoice', () {
      const id = 'mock-query';
      test('deleteInvoice calls right method with right id', () async {
        try {
          await invoiceRepository.deleteInvoice(id);
        } catch (_) {}
        verify(() => invoiceApiClient.deleteInvoice(id)).called(1);
      });
    });

    group('getInvoice', () {
      const id = 'mock-query';
      test('getInvoice calls right method with right id', () async {
        try {
          await invoiceRepository.getInvoice(id);
        } catch (_) {}
        verify(() => invoiceApiClient.getInvoiceById(id)).called(1);
      });

      test('returns correct Invoice on success', () async {
        final invoice = Invoice(
            userId: '62e393a5fb12b967fea3d9d0',
            id: '62e393a5fb12b967fea3d9d0',
            modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            paymentInformation: invoice_api.PaymentInformation(type: "type", details: "details"),
            paymentAfterTaxAndDiscount: 34,
            clientId: '62e393a5fb12b967fea3d9d0',
            invoiceNumber: '24235236432',
            isPaid: false,
            deliveryDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            discount: 0.1,
            itemList: [],
            paymentDate: DateTime.parse("2022-08-11T09:12:11.524Z")
        );
        when(() => invoiceApiClient.getInvoiceById(any())).thenAnswer(
              (_) async => invoice,
        );
        final actual = await invoiceRepository.getInvoice(id);
        expect(
          actual,
            Invoice(
                userId: '62e393a5fb12b967fea3d9d0',
                id: '62e393a5fb12b967fea3d9d0',
                modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                paymentInformation: invoice_api.PaymentInformation(type: "type", details: "details"),
                paymentAfterTaxAndDiscount: 34,
                clientId: '62e393a5fb12b967fea3d9d0',
                invoiceNumber: '24235236432',
                isPaid: false,
                deliveryDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                discount: 0.1,
                itemList: [],
                paymentDate: DateTime.parse("2022-08-11T09:12:11.524Z")
            )
        );
      });

    });
    group('getInvoices', () {
      const id = 'mock-query';
      test('getInvoices calls right method with right id', () async {
        try {
          await invoiceRepository.getInvoices({});
        } catch (_) {}
        verify(() => invoiceApiClient.getInvoices({})).called(1);
      });

      test('returns correct Object on success', () async {
        final invoice = Invoice(
            userId: '62e393a5fb12b967fea3d9d0',
            id: '62e393a5fb12b967fea3d9d0',
            modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            paymentInformation: invoice_api.PaymentInformation(type: "type", details: "details"),
            paymentAfterTaxAndDiscount: 34,
            clientId: '62e393a5fb12b967fea3d9d0',
            invoiceNumber: '24235236432',
            isPaid: false,
            deliveryDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            discount: 0.1,
            itemList: [],
            paymentDate: DateTime.parse("2022-08-11T09:12:11.524Z")
        );
        when(() => invoiceApiClient.getInvoices({})).thenAnswer(
              (_) async => {"invoiceList": [invoice], "lastN": 1},
        );
        final actual = await invoiceRepository.getInvoices({});
        expect(
            actual,
            InvoiceResponse(invoiceList: [Invoice(
                userId: '62e393a5fb12b967fea3d9d0',
                id: '62e393a5fb12b967fea3d9d0',
                modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                paymentInformation: invoice_api.PaymentInformation(type: "type", details: "details"),
                paymentAfterTaxAndDiscount: 34,
                clientId: '62e393a5fb12b967fea3d9d0',
                invoiceNumber: '24235236432',
                isPaid: false,
                deliveryDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                discount: 0.1,
                itemList: [],
                paymentDate: DateTime.parse("2022-08-11T09:12:11.524Z")
            )],
                lastN: 1)
        );
      });

    });
    group('updateInvoice', () {
      final invoice = Invoice(
          userId: '62e393a5fb12b967fea3d9d0',
          id: '62e393a5fb12b967fea3d9d0',
          modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          paymentInformation: invoice_api.PaymentInformation(type: "type", details: "details"),
          paymentAfterTaxAndDiscount: 34,
          clientId: '62e393a5fb12b967fea3d9d0',
          invoiceNumber: '24235236432',
          isPaid: false,
          deliveryDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          discount: 0.1,
          itemList: [],
          paymentDate: DateTime.parse("2022-08-11T09:12:11.524Z")
      );
      test('calls update with correct invoice', () async {
        try {
          await invoiceRepository.updateInvoice(invoice);
        } catch (_) {}
        verify(() => invoiceApiClient.updateInvoice(invoice)).called(1);
      });
    });
    group('insert', () {
      final invoice = Invoice(
          userId: '62e393a5fb12b967fea3d9d0',
          id: '62e393a5fb12b967fea3d9d0',
          modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          paymentInformation: invoice_api.PaymentInformation(type: "type", details: "details"),
          paymentAfterTaxAndDiscount: 34,
          clientId: '62e393a5fb12b967fea3d9d0',
          invoiceNumber: '24235236432',
          isPaid: false,
          deliveryDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          discount: 0.1,
          itemList: [],
          paymentDate: DateTime.parse("2022-08-11T09:12:11.524Z")
      );
      test('calls insert with correct invoice', () async {
        try {
          await invoiceRepository.insertInvoice(invoice);
        } catch (_) {}
        verify(() => invoiceApiClient.insertInvoice(invoice)).called(1);
      });
    });
  });
}
