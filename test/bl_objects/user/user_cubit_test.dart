// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:easyinvoice/bl_objects/user/user_cubit.dart';
import 'package:invoice_api/invoice_api_client.dart';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bl_objects_repository/user/index.dart'
as user_repository;

import '../../helpers/hydrated_bloc.dart';

class MockUserRepository extends Mock
    implements user_repository.UserRepository {}

class MockUser extends Mock implements User {}

void main() {
  initHydratedStorage();

  group('userCubit', () {
    late User user;
    late user_repository.UserRepository userRepository;
    late UserCubit userCubit;
    late User ruser;
    late User ruser2;
    setUp(() async {
      ruser = User(
          id: '62e393a5fb12b967fea3d9d0',
          name: "sigmund",
          billingInformation: BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"),
          locale: Locale.DE,
          email: "g@g.com",
          welcomeScreenData1: false,
          welcomeScreenData2: false,
          welcomeScreenData3: false,
          creationDate: DateTime.now(),
          purchaseToken: ["daweef32r34t45t23e23e"],
          hasPremium: false,
          originalTransactionId: "originalTransactionId",
          subscriptionExpirationDate: DateTime.now(),
          modifiedDate: DateTime.now()
      );
      ruser2 = User(
          id: '62e393a5fb12b967fea3d9d0',
          name: "sigmund",
          billingInformation: BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"),
          locale: Locale.DE,
          email: "g@g.com2",
          welcomeScreenData1: false,
          welcomeScreenData2: false,
          welcomeScreenData3: false,
          creationDate: DateTime.now(),
          purchaseToken: ["daweef32r34t45t23e23e"],
          hasPremium: false,
          originalTransactionId: "originalTransactionId",
          subscriptionExpirationDate: DateTime.now(),
          modifiedDate: DateTime.now()
      );
      user = MockUser();
      userRepository = MockUserRepository();
      when(() => user.name).thenReturn("sigmund");
      when(() => user.billingInformation).thenReturn(BillingInformation(taxNumber: "5474352354", germanUstId: "123423634623", streetName: "streetName", paymentInformation: PaymentInformation(details: 'rerwerwerwe', type: 'other'), streetNumber: "streetNumber", postalCode: "435234", city: "city", phoneNumber: "4353475323423"),);
      when(() => user.locale).thenReturn(Locale.DE);
      when(() => user.creationDate).thenReturn(DateTime.now());
      when(() => user.modifiedDate).thenReturn(DateTime.now());
      when(() => user.email).thenReturn("g@g.com2");
      when(() => user.id).thenReturn("9f239d98v9889090a0f38c");
      when(() => user.welcomeScreenData1).thenReturn(false);
      when(() => user.welcomeScreenData2).thenReturn(false);
      when(() => user.welcomeScreenData3).thenReturn(false);
      when(() => user.purchaseToken).thenReturn(["daweef32r34t45t23e23e"]);
      when(() => user.hasPremium).thenReturn(false);
      when(() => user.originalTransactionId).thenReturn("originalTransactionId");
      when(() => user.subscriptionExpirationDate).thenReturn(DateTime.now());
      when(
            () => userRepository.getUser(any()),
      ).thenAnswer((_) async => ruser);
      userCubit = UserCubit(userRepository);
    });

    test('initial state is correct', () {
      final weatherCubit = UserCubit(userRepository);
      expect(weatherCubit.state, InitialState());
    });

    group('toJson/fromJson', () {
      test('work properly', () async {
        final userCubit = UserCubit(userRepository);
        await userCubit.fetchUser("id");
        when(() => userRepository.getUser("id")).thenAnswer((_) async => Future.value(ruser));
        print(userCubit.toJson(userCubit.state));
        expect(
          userCubit.fromJson(userCubit.toJson(userCubit.state)!),
          userCubit.state,
        );
      });
    });

    group('right states', () {
      test('is in UserFetched after user is returned', () async {
        final userCubit = UserCubit(userRepository);
        when(() => userRepository.getUser("id")).thenAnswer((_) async => Future.value(ruser));
        await userCubit.fetchUser("id");
        expect(
          UserFetchedState(user: ruser),
          userCubit.state,
        );
      });
      test('is in FailureState after exception is thrown', () async {
        final userCubit = UserCubit(userRepository);
        when(() => userRepository.getUser("id")).thenAnswer((_) async => throw Exception("crash"));
        await userCubit.fetchUser("id");
        expect(
          FailureState(errorMessage: "crash"),
          userCubit.state,
        );
      });
    });
    group('pagination', () {
      test('pagination works', () async {
        final userCubit = UserCubit(userRepository);
        when(() => userRepository.getUsers(any())).thenAnswer((_) async => Future.value(user_repository.UserResponse(userList: [ruser], lastN: 1)));
        await userCubit.fetchUsers(query: {}, pagination: true);
        when(() => userRepository.getUsers(any())).thenAnswer((_) async => Future.value(user_repository.UserResponse(userList: [ruser2], lastN: 2)));
        await userCubit.fetchUsers(query: {}, pagination: true);
        expect(
          UserListFetchedState(userList: [ruser, ruser2], lastN: 2),
          userCubit.state,
        );
      });
      test('pagination set on false works', () async {
        final userCubit = UserCubit(userRepository);
        when(() => userRepository.getUsers(any())).thenAnswer((_) async => Future.value(user_repository.UserResponse(userList: [ruser], lastN: 1)));
        await userCubit.fetchUsers(query: {}, pagination: true);
        when(() => userRepository.getUsers(any())).thenAnswer((_) async => Future.value(user_repository.UserResponse(userList: [ruser2], lastN: 2)));
        await userCubit.fetchUsers(query: {}, pagination: true);
        expect(
          UserListFetchedState(userList: [ruser, ruser2], lastN: 2),
          userCubit.state,
        );
        await userCubit.fetchUsers(query: {}, pagination: false);
        expect(
          UserListFetchedState(userList: [ruser2], lastN: 1),
          userCubit.state,
        );
      });
    });
  });
}
