// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class MockItemDTO extends Mock implements ItemDTO {}

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
    "insertedId": "62e393a5fb12b967fea3d9d0"
}''');
        when(() => httpClient.post(any(), body: {}))
            .thenAnswer((_) async => response);
        ItemDTO fakeItem = MockItemDTO();
        when(fakeItem.toJson).thenReturn({});
        final body = jsonEncode(fakeItem.toJson());
        try {
          await itemApiClient.insertItem(fakeItem);
        } catch (_) {}
        verify(
          () => httpClient.post(
            any(),
            headers: {"Content-Type": "application/json"},
            body: body,
          ),
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
        ItemDTO fakeItem = MockItemDTO();
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
        ItemDTO fakeItem = MockItemDTO();
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
        ItemDTO fakeItem = MockItemDTO();
        when(fakeItem.toJson).thenReturn({});
        final body = jsonEncode(fakeItem.toJson());
        try {
          await itemApiClient.insertItem(fakeItem);
        } catch (_) {}
        verify(
          () => httpClient.post(any(),
              body: body, headers: {"Content-Type": "application/json"}),
        ).called(1);
      });
      test('inserts item, id gets extracted correctly', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('''{
        "acknowledged": true,
        "insertedId": "62e393a5fb12b967fea3d9d0"
}''');
        ItemDTO fakeItem = MockItemDTO();
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
        ItemDTO fakeItem = MockItemDTO();
        when(fakeItem.toJson).thenReturn({});
        final body = jsonEncode(fakeItem.toJson());
        when(() => httpClient.post(any(),
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
        when(() => response.body).thenReturn(
            '{"id":"641ec65b3323dcbf06b7f45a","userId":"lXxeavIFaNfxE8pbKZpcchU7kyl1","title":"Schraube","description":"Eine Schraube","pricePerUnit":3,"tax":0,"discount":0,"creationDate":"2023-03-25T09:31:04.548Z","modifiedDates":["2023-03-25T09:31:04.548Z"]}');
        when(() => httpClient.get(any(), headers: any(named: "headers")))
            .thenAnswer((_) async => response);
        try {
          await itemApiClient.getItemById(id);
        } catch (_) {}
        verify(
          () => httpClient.get(any(), headers: any(named: "headers")),
        ).called(1);
      });

      test('getItems makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any(), headers: any(named: "headers")))
            .thenAnswer((_) async => response);
        try {
          await itemApiClient.getItems({});
        } catch (_) {}
        verify(
          () => httpClient.get(any()),
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
            '{"id":"641ec65b3323dcbf06b7f45a","userId":"lXxeavIFaNfxE8pbKZpcchU7kyl1","title":"Schraube","description":"Eine Schraube","pricePerUnit":3,"tax":0,"discount":0,"creationDate":"2023-03-25T09:31:04.548Z","modifiedDates":["2023-03-25T09:31:04.548Z"]}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await itemApiClient.getItemById(id);
        expect(
          actual,
          isA<ItemDTO>()
              .having((l) => l.title, 'title', 'Schraube')
              .having((l) => l.id, 'id', '641ec65b3323dcbf06b7f45a')
              .having((l) => l.userId, 'userId', 'lXxeavIFaNfxE8pbKZpcchU7kyl1')
              .having((l) => l.description, 'description', 'Eine Schraube')
              .having((l) => l.pricePerUnit, 'pricePerUnit', 3)
              .having((l) => l.tax, 'tax', 0)
              .having((l) => l.discount, 'discount', 0)
              .having((l) => l.creationDate, 'creationDate',
                  DateTime.parse("2023-03-25T09:31:04.548Z"))
              .having((l) => l.modifiedDates, 'modifiedDates',
                  [DateTime.parse("2023-03-25T09:31:04.548Z")]),
        );
      });

      test('getItems returns list of items on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
    "data": [{"id":"641ec65b3323dcbf06b7f45a","userId":"lXxeavIFaNfxE8pbKZpcchU7kyl1","title":"Schraube","description":"Eine Schraube","pricePerUnit":3,"tax":0,"discount":0,"creationDate":"2023-03-25T09:31:04.548Z","modifiedDates":["2023-03-25T09:31:04.548Z"]}],
    "lastN": 1
    
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final ItemResponse actual = await itemApiClient.getItems({});
        print(actual);
        expect(
          actual.itemList[0],
          isA<ItemDTO>()
              .having((l) => l.title, 'title', 'Schraube')
              .having((l) => l.id, 'id', '641ec65b3323dcbf06b7f45a')
              .having((l) => l.userId, 'userId', 'lXxeavIFaNfxE8pbKZpcchU7kyl1')
              .having((l) => l.description, 'description', 'Eine Schraube')
              .having((l) => l.pricePerUnit, 'pricePerUnit', 3)
              .having((l) => l.tax, 'tax', 0)
              .having((l) => l.discount, 'discount', 0)
              .having((l) => l.creationDate, 'creationDate',
                  DateTime.parse("2023-03-25T09:31:04.548Z"))
              .having((l) => l.modifiedDates, 'modifiedDates',
                  [DateTime.parse("2023-03-25T09:31:04.548Z")]),
        );
      });
    });
  });
}
