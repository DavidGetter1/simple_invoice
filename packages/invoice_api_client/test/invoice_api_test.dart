// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class MockInvoiceDTO extends Mock implements InvoiceDTO {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('invoiceApiClient', () {
    late http.Client httpClient;
    late InvoiceApiClient invoiceApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      invoiceApiClient = InvoiceApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(InvoiceApiClient(), isNotNull);
      });
    });

    group('invoice update', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''{
    "acknowledged": true,
    "modifiedCount": 1,
    "upsertedId": null,
    "upsertedCount": 0,
    "matchedCount": 1
}''');
        when(() => httpClient.put(any(), body: {}))
            .thenAnswer((_) async => response);
        InvoiceDTO fakeInvoiceDTO = MockInvoiceDTO();
        when(fakeInvoiceDTO.toJson).thenReturn({});
        final body = jsonEncode(fakeInvoiceDTO.toJson());
        try {
          await invoiceApiClient.insertInvoice(fakeInvoiceDTO);
        } catch (_) {}
        verify(
          () => httpClient.put(
              Uri.https(
                'us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/invoice',
              ),
              headers: {"Content-Type": "application/json"},
              body: body,
              encoding: null),
        ).called(1);
      });

      test('throws on wrong update', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''{
    "acknowledged": true,
    "modifiedCount": 0,
    "upsertedId": null,
    "upsertedCount": 0,
    "matchedCount": 1
}''');
        InvoiceDTO fakeInvoiceDTO = MockInvoiceDTO();
        when(fakeInvoiceDTO.toJson).thenReturn({});
        final body = jsonEncode(fakeInvoiceDTO.toJson());

        when(() => httpClient.put(any(),
                body: body, headers: {"Content-Type": "application/json"}))
            .thenAnswer((_) async => response);
        expect(
          () async => invoiceApiClient.updateInvoice(fakeInvoiceDTO),
          throwsA(isA<Exception>()),
        );
      });

      test('fails on non 200 status', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error on updating invoice"
}''');
        InvoiceDTO fakeInvoiceDTO = MockInvoiceDTO();
        when(fakeInvoiceDTO.toJson).thenReturn({});
        final body = jsonEncode(fakeInvoiceDTO.toJson());

        when(() => httpClient.put(any(),
                body: body, headers: {"Content-Type": "application/json"}))
            .thenAnswer((_) async => response);
        expect(
          () async => invoiceApiClient.updateInvoice(fakeInvoiceDTO),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('invoice insert', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('''{
        "acknowledged": true,
        "insertedId": "62e393a5fb12b967fea3d9d0"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        InvoiceDTO fakeInvoiceDTO = MockInvoiceDTO();
        when(fakeInvoiceDTO.toJson).thenReturn({});
        final body = jsonEncode(fakeInvoiceDTO.toJson());
        try {
          await invoiceApiClient.insertInvoice(fakeInvoiceDTO);
        } catch (_) {}
        verify(
          () => httpClient.put(
              Uri.https(
                'us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/invoice',
              ),
              body: body,
              headers: {"Content-Type": "application/json"}),
        ).called(1);
      });
      test('inserts invoice, id gets extracted correctly', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('''{
        "acknowledged": true,
        "insertedId": "62e393a5fb12b967fea3d9d0"
}''');
        InvoiceDTO fakeInvoiceDTO = MockInvoiceDTO();
        when(fakeInvoiceDTO.toJson).thenReturn({});
        final body = jsonEncode(fakeInvoiceDTO.toJson());
        when(() => httpClient.post(any(),
                body: body, headers: {"Content-Type": "application/json"}))
            .thenAnswer((_) async => response);

        String id = "62e393a5fb12b967fea3d9d0";
        try {
          id = await invoiceApiClient.insertInvoice(fakeInvoiceDTO);
        } catch (_) {}
        expect(id, "62e393a5fb12b967fea3d9d0");
      });

      test('fails on non 201 status', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error on inserting invoice"
}''');
        InvoiceDTO fakeInvoiceDTO = MockInvoiceDTO();
        when(fakeInvoiceDTO.toJson).thenReturn({});
        final body = jsonEncode(fakeInvoiceDTO.toJson());
        when(() => httpClient.put(any(),
                body: body, headers: {"Content-Type": "application/json"}))
            .thenAnswer((_) async => response);
        expect(
          () async => invoiceApiClient.insertInvoice(fakeInvoiceDTO),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('invoiceSearch', () {
      const id = 'mock-query';
      test('getInvoiceById makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await invoiceApiClient.getInvoiceById(id);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/invoice/$id'),
          ),
        ).called(1);
      });

      test('getInvoice makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await invoiceApiClient.getInvoices({});
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/invoice', {}),
          ),
        ).called(1);
      });

      test(
          'getInvoiceById throws InvoiceDTOIdRequestFailure on non-200 response',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error": "Argument passed in must be a string of 12 bytes or a string of 24 hex characters"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => invoiceApiClient.getInvoiceById(id),
          throwsA(isA<InvoiceIdRequestFailure>()),
        );
      });

      test('getInvoice throws Exception on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error": "Argument passed in must be a string of 12 bytes or a string of 24 hex characters"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => invoiceApiClient.getInvoices({}),
          throwsA(isA<Exception>()),
        );
      });

      test('getInvoiceById returns InvoiceDTO on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
    
        "id": "62e393a5fb12b967fea3d9d0",
        "invoiceNumber": "abcefghijklmnopqrstuvwxyztest",
        "userId": "62e393a5fb12b967fea3d9d0",
        "itemList": [{
          "quantity": 3,
          "quantityIdentifier": "kg",
          "id": "id"
        }],
        "discount": 0.19,
        "paymentInformation": {
          "type": "type",
          "details": "details"
        },
        "paymentAfterTaxAndDiscount": 34,
        "paymentDate": "2022-08-11T09:12:11.524Z",
        "deliveryDate": "2022-08-11T09:12:11.524Z",
        "creationDate": "2022-08-11T09:12:11.524Z",
        "modifiedDate": "2022-08-11T09:12:11.524Z",
        "isPaid": true,
        "clientId": "62e393a5fb12b967fea3d9d0"
    
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await invoiceApiClient.getInvoiceById(id);
        expect(
          actual,
          isA<InvoiceDTO>()
              .having((l) => l.invoiceNumber, 'invoiceNumber',
                  'abcefghijklmnopqrstuvwxyztest')
              .having((l) => l.id, 'id', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.userId, 'userId', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.itemList, 'itemList', [
                DetailedItem(quantity: 3, quantityIdentifier: "kg", id: "id")
              ])
              .having((l) => l.discount, 'discount', 0.19)
              .having((l) => l.paymentInformation, 'paymentInformation',
                  PaymentInformation(type: "type", details: "details"))
              .having((l) => l.paymentAfterTaxAndDiscount,
                  'paymentAfterTaxAndDiscount', 34)
              .having((l) => l.paymentDate, 'paymentDate',
                  DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.creationDate, 'creationDate',
                  DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.modifiedDates, 'modifiedDates',
                  [DateTime.parse("2022-08-11T09:12:11.524Z")])
              .having((l) => l.isPaid, 'isPaid', true)
              .having((l) => l.deliveryDate, 'deliveryDate',
                  DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having(
                  (l) => l.clientId, 'clientId', '62e393a5fb12b967fea3d9d0'),
        );
      });

      test('getInvoice returns list of invoices on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
    "data": [{
        "id": "62e393a5fb12b967fea3d9d0",
        "invoiceNumber": "abcefghijklmnopqrstuvwxyztest",
        "userId": "62e393a5fb12b967fea3d9d0",
        "itemList": [{
          "quantity": 3,
          "quantityIdentifier": "kg",
          "id": "id"
        }],
        "discount": 0.19,
        "paymentInformation": {
          "type": "type",
          "details": "details"
        },
        "paymentAfterTaxAndDiscount": 34,
        "paymentDate": "2022-08-11T09:12:11.524Z",
        "deliveryDate": "2022-08-11T09:12:11.524Z",
        "creationDate": "2022-08-11T09:12:11.524Z",
        "modifiedDate": "2022-08-11T09:12:11.524Z",
        "isPaid": true,
        "clientId": "62e393a5fb12b967fea3d9d0"
    }],
    "lastN": 1
    
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await invoiceApiClient.getInvoices({});
        print(actual);
        expect(
          actual["invoiceList"][0],
          isA<InvoiceDTO>()
              .having((l) => l.invoiceNumber, 'invoiceNumber',
                  'abcefghijklmnopqrstuvwxyztest')
              .having((l) => l.id, 'id', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.userId, 'userId', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.itemList, 'itemList', [
                DetailedItem(quantity: 3, quantityIdentifier: "kg", id: "id")
              ])
              .having((l) => l.discount, 'discount', 0.19)
              .having((l) => l.paymentInformation, 'paymentInformation',
                  PaymentInformation(type: "type", details: "details"))
              .having((l) => l.paymentAfterTaxAndDiscount,
                  'paymentAfterTaxAndDiscount', 34)
              .having((l) => l.paymentDate, 'paymentDate',
                  DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.creationDate, 'creationDate',
                  DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.modifiedDates, 'modifiedDates',
                  [DateTime.parse("2022-08-11T09:12:11.524Z")])
              .having((l) => l.isPaid, 'isPaid', true)
              .having((l) => l.deliveryDate, 'deliveryDate',
                  DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having(
                  (l) => l.clientId, 'clientId', '62e393a5fb12b967fea3d9d0'),
        );
      });
    });
  });
}
