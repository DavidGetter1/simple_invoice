// ignore_for_file: prefer_const_constructors
import 'package:bl_objects_repository/user/models/user.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:easyinvoice/settings/account/profile/user_cubit.dart';
import 'package:invoice_api_client/invoice_api_client.dart';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bl_objects_repository/user/index.dart' as user_repository;

import '../../helpers/hydrated_bloc.dart';

class MockUserRepository extends Mock
    implements user_repository.UserRepository {}

class MockUser extends Mock implements User {}

void main() {
  initHydratedStorage();

  group('userCubit', () {
    late user_repository.UserRepository userRepository;
    late UserCubit userCubit;
    late User user;
    late User user2;
    setUp(() async {
      user = User(
        id: '62e393a5fb12b967fea3d9d0',
        name: "sigmund",
        billingInformation: BillingInformation(
            taxNumber: "5474352354",
            germanUstId: "123423634623",
            streetName: "streetName",
            paymentInformation:
                PaymentInformation(details: 'rerwerwerwe', type: 'other'),
            streetNumber: "streetNumber",
            postalCode: "435234",
            city: "city",
            phoneNumber: "4353475323423"),
        locale: Locale.DE,
        email: "g@g.com",
        hasPremium: false,
      );
      user2 = User(
          id: '62e393a5fb12b967fea3d9d0',
          name: "sigmund",
          billingInformation: BillingInformation(
              taxNumber: "5474352354",
              germanUstId: "123423634623",
              streetName: "streetName",
              paymentInformation:
                  PaymentInformation(details: 'rerwerwerwe', type: 'other'),
              streetNumber: "streetNumber",
              postalCode: "435234",
              city: "city",
              phoneNumber: "4353475323423"),
          locale: Locale.DE,
          email: "g@g.com2",
          hasPremium: false);
      userRepository = MockUserRepository();
      userCubit = UserCubit(userRepository);
    });

    test('initial state is correct', () {
      final userCubit = UserCubit(userRepository);
      expect(userCubit.state, InitialState());
    });

    group('toJson/fromJson', () {
      test('work properly', () async {
        final userCubit = UserCubit(userRepository);
        when(() => userRepository.getUser("id"))
            .thenAnswer((_) async => Future.value(user));
        await userCubit.fetchUser("id");

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
        when(() => userRepository.getUser("id"))
            .thenAnswer((_) async => Future.value(user));
        await userCubit.fetchUser("id");
        expect(
          UserFetchedState(user: user),
          userCubit.state,
        );
      });
      test('is in FailureState after exception is thrown', () async {
        final userCubit = UserCubit(userRepository);
        when(() => userRepository.getUser("id"))
            .thenAnswer((_) async => throw Exception("crash"));
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
        when(() => userRepository.getUsers(any())).thenAnswer((_) async =>
            Future.value(
                user_repository.UserResponse(userList: [user], lastN: 1)));
        await userCubit.fetchUsers(query: {}, pagination: true);
        when(() => userRepository.getUsers(any())).thenAnswer((_) async =>
            Future.value(
                user_repository.UserResponse(userList: [user2], lastN: 2)));
        await userCubit.fetchUsers(query: {}, pagination: true);
        expect(
          UserListFetchedState(userList: [user, user2], lastN: 2),
          userCubit.state,
        );
      });
      test('pagination set on false works', () async {
        final userCubit = UserCubit(userRepository);
        when(() => userRepository.getUsers(any())).thenAnswer((_) async =>
            Future.value(
                user_repository.UserResponse(userList: [user], lastN: 1)));
        await userCubit.fetchUsers(query: {}, pagination: true);
        when(() => userRepository.getUsers(any())).thenAnswer((_) async =>
            Future.value(
                user_repository.UserResponse(userList: [user2], lastN: 2)));
        await userCubit.fetchUsers(query: {}, pagination: true);
        expect(
          UserListFetchedState(userList: [user, user2], lastN: 2),
          userCubit.state,
        );
        await userCubit.fetchUsers(query: {}, pagination: false);
        expect(
          UserListFetchedState(userList: [user2], lastN: 1),
          userCubit.state,
        );
      });
    });
  });
}
