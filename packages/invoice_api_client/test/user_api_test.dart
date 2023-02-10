// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invoice_api/invoice_api_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class MockUser extends Mock implements User {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('userApiClient', () {
    late http.Client httpClient;
    late UserApiClient userApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      userApiClient = UserApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(UserApiClient(), isNotNull);
      });
    });



    group('user update', () {
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
        User fakeUser = MockUser();
        when(fakeUser.toJson).thenReturn({});
        final body = jsonEncode(fakeUser.toJson());
        try {
          await userApiClient.insertUser(fakeUser);
        } catch (_) {}
        verify(
              () => httpClient.put(
              Uri.https(
                'us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/user',
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
        User fakeUser = MockUser();
        when(fakeUser.toJson).thenReturn({});
        final body = jsonEncode(fakeUser.toJson());

        when(() => httpClient.put(any(), body: body, headers: {"Content-Type":"application/json"})).thenAnswer((_) async => response);
        expect(
              () async => userApiClient.updateUser(fakeUser),
          throwsA(isA<Exception>()),
        );
      });

      test('fails on non 200 status', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error on updating user"
}''');
        User fakeUser = MockUser();
        when(fakeUser.toJson).thenReturn({});
        final body = jsonEncode(fakeUser.toJson());

        when(() => httpClient.put(any(),body: body,headers: {"Content-Type":"application/json"})).thenAnswer((_) async => response);
        expect(
              () async => userApiClient.updateUser(fakeUser),
          throwsA(isA<Exception>()),
        );
      });
    }
    );

    group('user insert', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('''{
        "acknowledged": true,
        "insertedId": "62e393a5fb12b967fea3d9d0"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        User fakeUser = MockUser();
        when(fakeUser.toJson).thenReturn({});
        final body = jsonEncode(fakeUser.toJson());
        try {
          await userApiClient.insertUser(fakeUser);
        } catch (_) {}
        verify(
              () => httpClient.put(
              Uri.https(
                'us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/user',
              ),
              body: body,
              headers: {"Content-Type": "application/json"}
          ),
        ).called(1);
      });
      test('inserts user, id gets extracted correctly', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(201);
        when(() => response.body).thenReturn('''{
        "acknowledged": true,
        "insertedId": "62e393a5fb12b967fea3d9d0"
}''');
        User fakeUser = MockUser();
        when(fakeUser.toJson).thenReturn({});
        final body = jsonEncode(fakeUser.toJson());
        when(() => httpClient.post(any(), body: body, headers: {"Content-Type": "application/json"})).thenAnswer((_) async => response);

        String id = "62e393a5fb12b967fea3d9d0";
        try {
          id = await userApiClient.insertUser(fakeUser);
        } catch (_) {}
        expect(id, "62e393a5fb12b967fea3d9d0");
      });

      test('fails on non 201 status', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error on inserting user"
}''');
        User fakeUser = MockUser();
        when(fakeUser.toJson).thenReturn({});
        final body = jsonEncode(fakeUser.toJson());
        when(() => httpClient.put(any(),body: body, headers: {"Content-Type": "application/json"} )).thenAnswer((_) async => response);
        expect(
              () async => userApiClient.insertUser(fakeUser),
          throwsA(isA<Exception>()),
        );
      });
    }
    );

    group('userSearch', () {
      const id = 'mock-query';
      test('getUserById makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await userApiClient.getUserById(id);
        } catch (_) {}
        verify(
              () => httpClient.get(
            Uri.https(
                'us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/user/$id'
            ),
          ),
        ).called(1);
      });

      test('getUsers makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await userApiClient.getUsers({});
        } catch (_) {}
        verify(
              () => httpClient.get(
            Uri.https(
                'us-central1-invoice-c63dc.cloudfunctions.net',
                '/api/v1/bl_objects/user',
                {}
            ),
          ),
        ).called(1);
      });



      test('getUserById throws UserIdRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error": "Argument passed in must be a string of 12 bytes or a string of 24 hex characters"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
              () async => userApiClient.getUserById(id),
          throwsA(isA<UserIdRequestFailure>()),
        );
      });

      test('getUsers throws Exception on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => response.body).thenReturn('''{
    "error": "Argument passed in must be a string of 12 bytes or a string of 24 hex characters"
}''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
              () async => userApiClient.getUsers({}),
          throwsA(isA<Exception>()),
        );
      });

      test('getUserById returns User on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
    "_id": "62e393a5fb12b967fea3d9d0",
    "billingInformation": {
        "streetName": "streetName",
        "streetNumber": "streetNumber",
        "postalCode": "435234",
        "city": "city",
        "taxNumber": "5474352354",
        "germanUstId": "123423634623",
        "phoneNumber": "4353475323423",
        "paymentInformation": {
            "type": "other",
            "details": "rerwerwerwe"
        }
    },
    "creationDate": "2022-08-11T09:12:11.524Z",
    "email": "demarcus@gmx.de",
    "hasPremium": false,
    "locale": "DE",
    "modifiedDate": "2022-08-11T09:12:11.524Z",
    "name": "abcedfghijklmnopqrstuvwxyztest",
    "originalTransactionId": "",
    "purchaseToken": [],
    "subscriptionExpirationDate": "2022-08-11T09:12:11.524Z",
    "welcomeScreenData1": false,
    "welcomeScreenData2": false,
    "welcomeScreenData3": false
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await userApiClient.getUserById(id);

        expect(
          actual,
          isA<User>()
              .having((l) => l.hasPremium, 'hasPremium', false)
              .having((l) => l.originalTransactionId, 'originalTransactionId', '')
              .having((l) => l.purchaseToken, 'purchaseToken', [])
              .having((l) => l.subscriptionExpirationDate, 'subscriptionExpirationDate', DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.name, 'name', 'abcedfghijklmnopqrstuvwxyztest')
              .having((l) => l.id, 'id', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.email, 'email', 'demarcus@gmx.de')
              .having((l) => l.welcomeScreenData1, 'welcomeScreenData1', false)
              .having((l) => l.locale, 'locale', Locale.DE)
              .having((l) => l.billingInformation, 'billingInformation', BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"))
              .having((l) => l.welcomeScreenData2, 'welcomeScreenData2', false)
              .having((l) => l.welcomeScreenData3, 'welcomeScreenData3', false)
              .having((l) => l.creationDate, 'creationDate', DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.modifiedDate, 'modifiedDate', DateTime.parse("2022-08-11T09:12:11.524Z"))
        );
      });

      test('getUsers returns list of users on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(
          '''
{
    "data": [{
        "_id": "62e393a5fb12b967fea3d9d0",
    "billingInformation": {
        "streetName": "streetName",
        "streetNumber": "streetNumber",
        "postalCode": "435234",
        "city": "city",
        "taxNumber": "5474352354",
        "germanUstId": "123423634623",
        "phoneNumber": "4353475323423",
        "paymentInformation": {
            "type": "other",
            "details": "rerwerwerwe"
        }
    },
    "creationDate": "2022-08-11T09:12:11.524Z",
    "email": "demarcus@gmx.de",
    "hasPremium": false,
    "locale": "DE",
    "modifiedDate": "2022-08-11T09:12:11.524Z",
    "name": "abcedfghijklmnopqrstuvwxyztest",
    "originalTransactionId": "",
    "purchaseToken": [],
    "subscriptionExpirationDate": "2022-08-11T09:12:11.524Z",
    "welcomeScreenData1": false,
    "welcomeScreenData2": false,
    "welcomeScreenData3": false
}],
    "lastN": 1
    
}''',
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await userApiClient.getUsers({});
        print(actual);
        expect(
          actual["userList"][0],
          isA<User>()
              .having((l) => l.hasPremium, 'hasPremium', false)
              .having((l) => l.originalTransactionId, 'originalTransactionId', '')
              .having((l) => l.purchaseToken, 'purchaseToken', [])
              .having((l) => l.subscriptionExpirationDate, 'subscriptionExpirationDate', DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.name, 'name', 'abcedfghijklmnopqrstuvwxyztest')
              .having((l) => l.id, 'id', '62e393a5fb12b967fea3d9d0')
              .having((l) => l.email, 'email', 'demarcus@gmx.de')
              .having((l) => l.welcomeScreenData1, 'welcomeScreenData1', false)
              .having((l) => l.locale, 'locale', Locale.DE)
              .having((l) => l.billingInformation, 'billingInformation', BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"))
              .having((l) => l.welcomeScreenData2, 'welcomeScreenData2', false)
              .having((l) => l.welcomeScreenData3, 'welcomeScreenData3', false)
              .having((l) => l.creationDate, 'creationDate', DateTime.parse("2022-08-11T09:12:11.524Z"))
              .having((l) => l.modifiedDate, 'modifiedDate', DateTime.parse("2022-08-11T09:12:11.524Z"))
        );
      });
    });
  });
}
