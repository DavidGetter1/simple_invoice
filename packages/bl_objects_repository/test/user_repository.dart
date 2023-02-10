// ignore_for_file: prefer_const_constructors
import 'package:invoice_api/invoice_api_client.dart' as invoice_api;
import 'package:invoice_api/invoice_api_client.dart';
import 'package:bl_objects_repository/user/index.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockUserApiClient extends Mock
    implements invoice_api.UserApiClient {}

class MockUser extends Mock implements invoice_api.User { }
void main() {
  group('UserRepository', () {
    late invoice_api.UserApiClient userApiClient;
    late UserRepository userRepository;

    setUp(() {
      userApiClient = MockUserApiClient();
      userRepository = UserRepository(
        userApiClient: userApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal MetaWeatherApiClient when not injected', () {
        expect(UserRepository(), isNotNull);
      });
    });

    group('deleteUser', () {
      const id = 'mock-query';
      test('deleteUser calls right method with right id', () async {
        try {
          await userRepository.deleteUser(id);
        } catch (_) {}
        verify(() => userApiClient.deleteUser(id)).called(1);
      });
    });

    group('getUser', () {
      const id = 'mock-query';
      test('getUser calls right method with right id', () async {
        try {
          await userRepository.getUser(id);
        } catch (_) {}
        verify(() => userApiClient.getUserById(id)).called(1);
      });

      test('returns correct User on success', () async {
        final user = User(
            id: '62e393a5fb12b967fea3d9d0',
            name: "sigmund",
            billingInformation: BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"),
            locale: Locale.DE,
            email: "g@g.com",
            welcomeScreenData1: false,
            welcomeScreenData2: false,
            welcomeScreenData3: false,
            creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            purchaseToken: ["daweef32r34t45t23e23e"],
            hasPremium: false,
            originalTransactionId: "originalTransactionId",
            subscriptionExpirationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z")
        );
        when(() => userApiClient.getUserById(any())).thenAnswer(
              (_) async => user,
        );
        final actual = await userRepository.getUser(id);
        expect(
          actual,
          User(
              id: '62e393a5fb12b967fea3d9d0',
              name: "sigmund",
              billingInformation: BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"),
              locale: Locale.DE,
              email: "g@g.com",
              welcomeScreenData1: false,
              welcomeScreenData2: false,
              welcomeScreenData3: false,
              creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
              purchaseToken: ["daweef32r34t45t23e23e"],
              hasPremium: false,
              originalTransactionId: "originalTransactionId",
              subscriptionExpirationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
              modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z")
          ),
        );
      });

    });
    group('getUsers', () {
      const id = 'mock-query';
      test('getUsers calls right method with right id', () async {
        try {
          await userRepository.getUsers({});
        } catch (_) {}
        verify(() => userApiClient.getUsers({})).called(1);
      });

      test('returns correct Object on success', () async {
        final user = User(
            id: '62e393a5fb12b967fea3d9d0',
            name: "sigmund",
            billingInformation: BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"),
            locale: Locale.DE,
            email: "g@g.com",
            welcomeScreenData1: false,
            welcomeScreenData2: false,
            welcomeScreenData3: false,
            creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            purchaseToken: ["daweef32r34t45t23e23e"],
            hasPremium: false,
            originalTransactionId: "originalTransactionId",
            subscriptionExpirationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z")
        );
        when(() => userApiClient.getUsers({})).thenAnswer(
              (_) async => {"userList": [user], "lastN": 1},
        );
        final actual = await userRepository.getUsers({});
        expect(
            actual,
            UserResponse(userList: [User(
                id: '62e393a5fb12b967fea3d9d0',
                name: "sigmund",
                billingInformation: BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"),
                locale: Locale.DE,
                email: "g@g.com",
                welcomeScreenData1: false,
                welcomeScreenData2: false,
                welcomeScreenData3: false,
                creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                purchaseToken: ["daweef32r34t45t23e23e"],
                hasPremium: false,
                originalTransactionId: "originalTransactionId",
                subscriptionExpirationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z")
            )],
                lastN: 1)
        );
      });

    });
    group('updateUser', () {
      final user = User(
          id: '62e393a5fb12b967fea3d9d0',
          name: "sigmund",
          billingInformation: BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"),
          locale: Locale.DE,
          email: "g@g.com",
          welcomeScreenData1: false,
          welcomeScreenData2: false,
          welcomeScreenData3: false,
          creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          purchaseToken: ["daweef32r34t45t23e23e"],
          hasPremium: false,
          originalTransactionId: "originalTransactionId",
          subscriptionExpirationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z")
      );
      test('calls update with correct user', () async {
        try {
          await userRepository.updateUser(user);
        } catch (_) {}
        verify(() => userApiClient.updateUser(user)).called(1);
      });
    });
    group('insert', () {
      final user = User(
          id: '62e393a5fb12b967fea3d9d0',
          name: "sigmund",
          billingInformation: BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"),
          locale: Locale.DE,
          email: "g@g.com",
          welcomeScreenData1: false,
          welcomeScreenData2: false,
          welcomeScreenData3: false,
          creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          purchaseToken: ["daweef32r34t45t23e23e"],
          hasPremium: false,
          originalTransactionId: "originalTransactionId",
          subscriptionExpirationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z")
      );
      test('calls insert with correct user', () async {
        try {
          await userRepository.insertUser(user);
        } catch (_) {}
        verify(() => userApiClient.insertUser(user)).called(1);
      });
    });
  });
}
