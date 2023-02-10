// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:easyinvoice/bl_objects/client/client_cubit.dart';
import 'package:invoice_api/invoice_api_client.dart';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bl_objects_repository/client/index.dart'
as client_repository;

import '../../helpers/hydrated_bloc.dart';



class MockClientRepository extends Mock
    implements client_repository.ClientRepository {}

class MockClient extends Mock implements Client {}

void main() {
  initHydratedStorage();

  group('clientCubit', () {
    late Client client;
    late client_repository.ClientRepository clientRepository;
    late ClientCubit clientCubit;
    late Client rclient;
    late Client rclient2;
    setUp(() async {
      rclient = Client(
          userId: '62e393a5fb12b967fea3d9d0',
          name: "name",
          streetName: "streetName",
          streetNumber: "streetNumber",
          postalCode: "postalCode",
          city: "city",
          phoneNumber: "019285973935",
          email: "email@s.ds",
          creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          id: '62e393a5fb12b967fea3d9d0');
      rclient2 = Client(
          userId: '62e393a5fb12b967fea3d9d0',
          name: "name",
          streetName: "streetName",
          streetNumber: "streetNumber",
          postalCode: "postalCode",
          city: "city",
          phoneNumber: "019285973935",
          email: "email@s.ds",
          creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          id: '62e393a5fb12b967fea3d9d0');
      client = MockClient();
      clientRepository = MockClientRepository();
      when(() => client.name).thenReturn("name");
      when(() => client.streetNumber).thenReturn("streetName");
      when(() => client.streetNumber).thenReturn("streetNumber");
      when(() => client.creationDate).thenReturn(DateTime.now());
      when(() => client.modifiedDate).thenReturn(DateTime.now());
      when(() => client.postalCode).thenReturn("postalCode");
      when(() => client.id).thenReturn("9f239d98v9889090a0f38c");
      when(() => client.userId).thenReturn("9f239d98v9889090a0f38c");
      when(() => client.email).thenReturn("email@s.ds");
      when(() => client.city).thenReturn("city");
      when(() => client.phoneNumber).thenReturn("019285973935");
      when(
            () => clientRepository.getClient(any()),
      ).thenAnswer((_) async => rclient);
      clientCubit = ClientCubit(clientRepository);
    });

    test('initial state is correct', () {
      final weatherCubit = ClientCubit(clientRepository);
      expect(weatherCubit.state, InitialState());
    });

    group('toJson/fromJson', () {
      test('work properly', () async {
        final clientCubit = ClientCubit(clientRepository);
        await clientCubit.fetchClient("id");
        when(() => clientRepository.getClient("id")).thenAnswer((_) async => Future.value(rclient));
        expect(
          clientCubit.fromJson(clientCubit.toJson(clientCubit.state)!),
          clientCubit.state,
        );
      });
    });

    group('right states', () {
      test('is in ClientFetched after client is returned', () async {
        final clientCubit = ClientCubit(clientRepository);
        when(() => clientRepository.getClient("id")).thenAnswer((_) async => Future.value(rclient));
        await clientCubit.fetchClient("id");
        expect(
          ClientFetchedState(client: rclient),
          clientCubit.state,
        );
      });
      test('is in FailureState after exception is thrown', () async {
        final clientCubit = ClientCubit(clientRepository);
        when(() => clientRepository.getClient("id")).thenAnswer((_) async => throw Exception("crash"));
        await clientCubit.fetchClient("id");
        expect(
          FailureState(errorMessage: "crash"),
          clientCubit.state,
        );
      });
    });
    group('pagination', () {
      test('pagination works', () async {
        final clientCubit = ClientCubit(clientRepository);
        when(() => clientRepository.getClients(any())).thenAnswer((_) async => Future.value(client_repository.ClientResponse(clientList: [rclient], lastN: 1)));
        await clientCubit.fetchClients(query: {}, pagination: true);
        when(() => clientRepository.getClients(any())).thenAnswer((_) async => Future.value(client_repository.ClientResponse(clientList: [rclient2], lastN: 2)));
        await clientCubit.fetchClients(query: {}, pagination: true);
        expect(
          ClientListFetchedState(clientList: [rclient, rclient2], lastN: 2),
          clientCubit.state,
        );
      });
      test('pagination set on false works', () async {
        final clientCubit = ClientCubit(clientRepository);
        when(() => clientRepository.getClients(any())).thenAnswer((_) async => Future.value(client_repository.ClientResponse(clientList: [rclient], lastN: 1)));
        await clientCubit.fetchClients(query: {}, pagination: true);
        when(() => clientRepository.getClients(any())).thenAnswer((_) async => Future.value(client_repository.ClientResponse(clientList: [rclient2], lastN: 2)));
        await clientCubit.fetchClients(query: {}, pagination: true);
        expect(
          ClientListFetchedState(clientList: [rclient, rclient2], lastN: 2),
          clientCubit.state,
        );
        await clientCubit.fetchClients(query: {}, pagination: false);
        expect(
          ClientListFetchedState(clientList: [rclient2], lastN: 1),
          clientCubit.state,
        );
      });
    });
  });
}
