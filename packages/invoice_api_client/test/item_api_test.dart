// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:invoice_api_client/items/models/itemDTOSend.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class MockItemDTOReceive extends Mock implements ItemDTOReceive {}

class MockItemDTOSend extends Mock implements ItemDTOSend {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('itemApiClient', () {
    late http.Client httpClient;
    late ItemApiClient itemApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      itemApiClient = ItemApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(ItemApiClient(), isNotNull);
      });
    });

    group('item update', () {
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
        ItemDTOSend fakeItem = MockItemDTOSend();
        when(fakeItem.toJson).thenReturn({});
        final body = jsonEncode(fakeItem.toJson());
        try {
          await itemApiClient.insertItem(fakeItem);
        } catch (_) {}
        verify(
          () => httpClient.put(
              Uri.https(
                'us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/item',
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
        ItemDTOReceive fakeItem = MockItemDTOReceive();
        when(fakeItem.toJson).thenReturn({});
        final body = jsonEncode(fakeItem.toJson());

        when(() => httpClient.put(any(),
                body: body, headers: {"Content-Type": "application/json"}))
            .thenAnswer((_) async => response);
        expect(
          () async => itemApiClient.updateItem(fakeItem),
          throwsA(isA<Exception>()),
        );
      });

      test('fails on non 200 status', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error on updating item"
}''');
        ItemDTOReceive fakeItem = MockItemDTOReceive();
        when(fakeItem.toJson).thenReturn({});
        final body = jsonEncode(fakeItem.toJson());

        when(() => httpClient.put(any(),
                body: body, headers: {"Content-Type": "application/json"}))
            .thenAnswer((_) async => response);
        expect(
          () async => itemApiClient.updateItem(fakeItem),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('item insert', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('''{
        "acknowledged": true,
        "insertedId": "62e393a5fb12b967fea3d9d0"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        ItemDTOSend fakeItem = MockItemDTOSend();
        when(fakeItem.toJson).thenReturn({});
        final body = jsonEncode(fakeItem.toJson());
        try {
          await itemApiClient.insertItem(fakeItem);
        } catch (_) {}
        verify(
          () => httpClient.put(
              Uri.https(
                'us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/item',
              ),
              body: body,
              headers: {"Content-Type": "application/json"}),
        ).called(1);
      });
      test('inserts item, id gets extracted correctly', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('''{
        "acknowledged": true,
        "insertedId": "62e393a5fb12b967fea3d9d0"
}''');
        ItemDTOSend fakeItem = MockItemDTOSend();
        when(fakeItem.toJson).thenReturn({});
        final body = jsonEncode(fakeItem.toJson());
        when(() => httpClient.post(any(),
                body: body, headers: {"Content-Type": "application/json"}))
            .thenAnswer((_) async => response);

        String id = "62e393a5fb12b967fea3d9d0";
        try {
          id = await itemApiClient.insertItem(fakeItem);
        } catch (_) {}
        expect(id, "62e393a5fb12b967fea3d9d0");
      });

      test('fails on non 201 status', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error on inserting item"
}''');
        ItemDTOSend fakeItem = MockItemDTOSend();
        when(fakeItem.toJson).thenReturn({});
        final body = jsonEncode(fakeItem.toJson());
        when(() => httpClient.put(any(),
                body: body, headers: {"Content-Type": "application/json"}))
            .thenAnswer((_) async => response);
        expect(
          () async => itemApiClient.insertItem(fakeItem),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('itemSearch', () {
      const id = 'mock-query';
      test('getItemById makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await itemApiClient.getItemById(id);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/item/$id'),
          ),
        ).called(1);
      });

      test('getItems makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await itemApiClient.getItems({});
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/item', {}),
          ),
        ).called(1);
      });

      test('getItemById throws ItemIdRequestFailure on non-200 response',
          () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error": "Argument passed in must be a string of 12 bytes or a string of 24 hex characters"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => itemApiClient.getItemById(id),
          throwsA(isA<ItemIdRequestFailure>()),
        );
      });

      test('getItems throws Exception on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error": "Argument passed in must be a string of 12 bytes or a string of 24 hex characters"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => itemApiClient.getItems({}),
          throwsA(isA<Exception>()),
        );
      });

      test('getItemById returns Item on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
    
        "_id": "62e393a5fb12b967fea3d9d0",
        "userId": "62e393a5fb12b967fea3d9d0",
        "title": "abcefghijklmnopqrstuvwxyztest",
        "description": "Bricks for construction",
        "pricePerUnit": 17.625,
        "tax": 0.19,
        "discount": 0.02,
        "taxedAmount": 15,
        "taxIncluded": true,
        "creationDate": "2022-08-11T09:12:11.524Z",
        "modifiedDate": "2022-08-11T09:12:11.524Z"
    
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await itemApiClient.getItemById(id);
        expect(
          actual,
          isA<ItemDTOReceive>()
              .having((l) => l.title, 'title', 'abcefghijklmnopqrstuvwxyztest')
              .having((l) => l.id, 'id', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.userId, 'userId', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.description, 'description',
                  'Bricks for construction')
              .having((l) => l.pricePerUnit, 'pricePerUnit', 17.625)
              .having((l) => l.tax, 'tax', 0.19)
              .having((l) => l.discount, 'discount', 0.02)
              .having((l) => l.taxIncluded, 'taxIncluded', true)
              .having((l) => l.creationDate, 'creationDate',
                  DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.modifiedDate, 'modifiedDate',
                  DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.taxedAmount, 'taxedAmount', 15),
        );
      });

      test('getItems returns list of items on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
    "data": [{
        "_id": "62e393a5fb12b967fea3d9d0",
        "userId": "62e393a5fb12b967fea3d9d0",
        "title": "abcefghijklmnopqrstuvwxyztest",
        "description": "Bricks for construction",
        "pricePerUnit": 17.625,
        "tax": 0.19,
        "discount": 0.02,
        "taxedAmount": 15,
        "taxIncluded": true,
        "creationDate": "2022-08-11T09:12:11.524Z",
        "modifiedDate": "2022-08-11T09:12:11.524Z"
    }],
    "lastN": 1
    
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await itemApiClient.getItems({});
        print(actual);
        expect(
          actual["itemList"][0],
          isA<ItemDTOReceive>()
              .having((l) => l.title, 'title', 'abcefghijklmnopqrstuvwxyztest')
              .having((l) => l.id, 'id', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.userId, 'userId', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.description, 'description',
                  'Bricks for construction')
              .having((l) => l.pricePerUnit, 'pricePerUnit', 17.625)
              .having((l) => l.tax, 'tax', 0.19)
              .having((l) => l.discount, 'discount', 0.02)
              .having((l) => l.taxIncluded, 'taxIncluded', true)
              .having((l) => l.creationDate, 'creationDate',
                  DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.modifiedDate, 'modifiedDate',
                  DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.taxedAmount, 'taxedAmount', 15),
        );
      });
    });
  });
}
