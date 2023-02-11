// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class MockClient extends Mock implements Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('clientApiClient', () {
    late http.Client httpClient;
    late ClientApiClient clientApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      clientApiClient = ClientApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(ClientApiClient(), isNotNull);
      });
    });



    group('client update', () {
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
        when(() => httpClient.put(any(), body: {})).thenAnswer((_) async => response);
        Client fakeClient = MockClient();
        when(fakeClient.toJson).thenReturn({});
        final body = jsonEncode(fakeClient.toJson());
        try {
          await clientApiClient.insertClient(fakeClient);
        } catch (_) {}
        verify(
              () => httpClient.put(
              Uri.https(
                'us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/client',
              ),
                  headers: {"Content-Type": "application/json"},
                  body: body,
                  encoding: null
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
        Client fakeClient = MockClient();
        when(fakeClient.toJson).thenReturn({});
        final body = jsonEncode(fakeClient.toJson());

        when(() => httpClient.put(any(), body: body, headers: {"Content-Type":"application/json"})).thenAnswer((_) async => response);
        expect(
              () async => clientApiClient.updateClient(fakeClient),
          throwsA(isA<Exception>()),
        );
      });

      test('fails on non 200 status', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error on updating client"
}''');
        Client fakeClient = MockClient();
        when(fakeClient.toJson).thenReturn({});
        final body = jsonEncode(fakeClient.toJson());

        when(() => httpClient.put(any(),body: body,headers: {"Content-Type":"application/json"})).thenAnswer((_) async => response);
        expect(
              () async => clientApiClient.updateClient(fakeClient),
          throwsA(isA<Exception>()),
        );
      });
    }
    );

    group('client insert', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('''{
        "acknowledged": true,
        "insertedId": "62e393a5fb12b967fea3d9d0"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        Client fakeClient = MockClient();
        when(fakeClient.toJson).thenReturn({});
        final body = jsonEncode(fakeClient.toJson());
        try {
          await clientApiClient.insertClient(fakeClient);
        } catch (_) {}
        verify(
              () => httpClient.put(
              Uri.https(
                'us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/client',
              ),
              body: body,
                  headers: {"Content-Type": "application/json"}
              ),
        ).called(1);
      });
      test('inserts client, id gets extracted correctly', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('''{
        "acknowledged": true,
        "insertedId": "62e393a5fb12b967fea3d9d0"
}''');
        Client fakeClient = MockClient();
        when(fakeClient.toJson).thenReturn({});
        final body = jsonEncode(fakeClient.toJson());
        when(() => httpClient.post(any(), body: body, headers: {"Content-Type": "application/json"})).thenAnswer((_) async => response);

        String id = "62e393a5fb12b967fea3d9d0";
        try {
          id = await clientApiClient.insertClient(fakeClient);
        } catch (_) {}
        expect(id, "62e393a5fb12b967fea3d9d0");
      });

      test('fails on non 201 status', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error on inserting client"
}''');
        Client fakeClient = MockClient();
        when(fakeClient.toJson).thenReturn({});
        final body = jsonEncode(fakeClient.toJson());
        when(() => httpClient.put(any(),body: body, headers: {"Content-Type": "application/json"} )).thenAnswer((_) async => response);
        expect(
              () async => clientApiClient.insertClient(fakeClient),
          throwsA(isA<Exception>()),
        );
      });
    }
    );

    group('clientSearch', () {
      const id = 'mock-query';
      test('getClientById makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await clientApiClient.getClientById(id);
        } catch (_) {}
        verify(
              () => httpClient.get(
            Uri.https(
              'us-central1-invoice-c63dc.cloudfunctions.net',
              '/api/v1/bl_objects/client/$id'
            ),
          ),
        ).called(1);
      });

      test('getClients makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await clientApiClient.getClients({});
        } catch (_) {}
        verify(
              () => httpClient.get(
            Uri.https(
              'us-central1-invoice-c63dc.cloudfunctions.net',
              '/api/v1/bl_objects/client',
              {}
            ),
          ),
        ).called(1);
      });



      test('getClientById throws ClientIdRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error": "Argument passed in must be a string of 12 bytes or a string of 24 hex characters"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
              () async => clientApiClient.getClientById(id),
          throwsA(isA<ClientIdRequestFailure>()),
        );
      });

      test('getClients throws Exception on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error": "Argument passed in must be a string of 12 bytes or a string of 24 hex characters"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
              () async => clientApiClient.getClients({}),
          throwsA(isA<Exception>()),
        );
      });

      test('getClientById returns Client on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
    
        "_id": "62e393a5fb12b967fea3d9d0",
        "userId": "62e393a5fb12b967fea3d9d0",
        "name": "abcefghijklmnopqrstuvwxyztest",
        "city": "hamburg",
        "postalCode": "22111",
        "streetName": "washingtonallee",
        "streetNumber": "13a",
        "phoneNumber": "200248092374",
        "taxIncluded": true,
        "creationDate": "2022-08-11T09:12:11.524Z",
        "modifiedDate": "2022-08-11T09:12:11.524Z",
        "email": "erna@bert.de"
    
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await clientApiClient.getClientById(id);
        expect(
          actual,
          isA<Client>()
              .having((l) => l.name, 'name', 'abcefghijklmnopqrstuvwxyztest')
              .having((l) => l.id, 'id', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.userId, 'userId', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.city, 'city', 'hamburg')
              .having((l) => l.postalCode, 'postalCode', "22111")
              .having((l) => l.streetName, 'streetName', "washingtonallee")
              .having((l) => l.streetNumber, 'streetNumber', "13a")
              .having((l) => l.phoneNumber, 'phoneNumber', "200248092374")
              .having((l) => l.creationDate, 'creationDate', DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.modifiedDate, 'modifiedDate', DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.email, 'email', "erna@bert.de"),
        );
      });

      test('getClients returns list of clients on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
    "data": [{
        "_id": "62e393a5fb12b967fea3d9d0",
        "userId": "62e393a5fb12b967fea3d9d0",
        "name": "abcefghijklmnopqrstuvwxyztest",
        "city": "hamburg",
        "postalCode": "22111",
        "streetName": "washingtonallee",
        "streetNumber": "13a",
        "phoneNumber": "200248092374",
        "taxIncluded": true,
        "creationDate": "2022-08-11T09:12:11.524Z",
        "modifiedDate": "2022-08-11T09:12:11.524Z",
        "email": "erna@bert.de"
    
    }],
    "lastN": 1
    
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await clientApiClient.getClients({});
        print(actual);
        expect(
          actual["clientList"][0],
          isA<Client>()
              .having((l) => l.name, 'name', 'abcefghijklmnopqrstuvwxyztest')
              .having((l) => l.id, 'id', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.userId, 'userId', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.city, 'city', 'hamburg')
              .having((l) => l.postalCode, 'postalCode', "22111")
              .having((l) => l.streetName, 'streetName', "washingtonallee")
              .having((l) => l.streetNumber, 'streetNumber', "13a")
              .having((l) => l.phoneNumber, 'phoneNumber', "200248092374")
              .having((l) => l.creationDate, 'creationDate', DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.modifiedDate, 'modifiedDate', DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.email, 'email', "erna@bert.de"),
        );
      });
    });
  });
}
