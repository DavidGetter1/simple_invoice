// ignore_for_file: prefer_const_constructors
import 'package:invoice_api_client/invoice_api_client.dart' as invoice_api;
import 'package:bl_objects_repository/client/index.dart';
import 'package:invoice_api_client/clients/models/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockClientApiClient extends Mock
    implements invoice_api.ClientApiClient {}

class MockClient extends Mock implements invoice_api.Client { }
void main() {
  group('ClientRepository', () {
    late invoice_api.ClientApiClient clientApiClient;
    late ClientRepository clientRepository;

    setUp(() {
      clientApiClient = MockClientApiClient();
      clientRepository = ClientRepository(
        clientApiClient: clientApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal MetaWeatherApiClient when not injected', () {
        expect(ClientRepository(), isNotNull);
      });
    });

    group('deleteClient', () {
      const id = 'mock-query';
      test('deleteClient calls right method with right id', () async {
        try {
          await clientRepository.deleteClient(id);
        } catch (_) {}
        verify(() => clientApiClient.deleteClient(id)).called(1);
      });
    });

    group('getClient', () {
      const id = 'mock-query';
      test('getClient calls right method with right id', () async {
        try {
          await clientRepository.getClient(id);
        } catch (_) {}
        verify(() => clientApiClient.getClientById(id)).called(1);
      });

      test('returns correct Client on success', () async {
        final client = Client(
            userId: '62e393a5fb12b967fea3d9d0',
            id: '62e393a5fb12b967fea3d9d0',
            modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            phoneNumber: '087632523634',
            postalCode: '22766',
            streetName: 'Washingtonallee',
            name: 'helmut',
            email: 'helmut@was.de',
            city: 'murcia(easter egg)',
            streetNumber: '24'
        );
        when(() => clientApiClient.getClientById(any())).thenAnswer(
              (_) async => client,
        );
        final actual = await clientRepository.getClient(id);
        expect(
          actual,
          Client(
              userId: '62e393a5fb12b967fea3d9d0',
              id: '62e393a5fb12b967fea3d9d0',
              modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
              creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
              phoneNumber: '087632523634',
              postalCode: '22766',
              streetName: 'Washingtonallee',
              name: 'helmut',
              email: 'helmut@was.de',
              city: 'murcia(easter egg)',
              streetNumber: '24'
          ),
        );
      });

    });
    group('getClients', () {
      const id = 'mock-query';
      test('getClients calls right method with right id', () async {
        try {
          await clientRepository.getClients({});
        } catch (_) {}
        verify(() => clientApiClient.getClients({})).called(1);
      });

      test('returns correct Object on success', () async {
        final client = Client(
            userId: '62e393a5fb12b967fea3d9d0',
            id: '62e393a5fb12b967fea3d9d0',
            modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            phoneNumber: '087632523634',
            postalCode: '22766',
            streetName: 'Washingtonallee',
            name: 'helmut',
            email: 'helmut@was.de',
            city: 'murcia(easter egg)',
            streetNumber: '24'
        );
        when(() => clientApiClient.getClients({})).thenAnswer(
              (_) async => {"clientList": [client], "lastN": 1},
        );
        final actual = await clientRepository.getClients({});
        expect(
            actual,
            ClientResponse(clientList: [Client(
                userId: '62e393a5fb12b967fea3d9d0',
                id: '62e393a5fb12b967fea3d9d0',
                modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                phoneNumber: '087632523634',
                postalCode: '22766',
                streetName: 'Washingtonallee',
                name: 'helmut',
                email: 'helmut@was.de',
                city: 'murcia(easter egg)',
                streetNumber: '24'
            )],
                lastN: 1)
        );
      });

    });
    group('updateClient', () {
      final client = Client(
          userId: '62e393a5fb12b967fea3d9d0',
          id: '62e393a5fb12b967fea3d9d0',
          modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          phoneNumber: '087632523634',
          postalCode: '22766',
          streetName: 'Washingtonallee',
          name: 'helmut',
          email: 'helmut@was.de',
          city: 'murcia(easter egg)',
          streetNumber: '24'
      );;
      test('calls update with correct client', () async {
        try {
          await clientRepository.updateClient(client);
        } catch (_) {}
        verify(() => clientApiClient.updateClient(client)).called(1);
      });
    });
    group('insert', () {
      final client = Client(
          userId: '62e393a5fb12b967fea3d9d0',
          id: '62e393a5fb12b967fea3d9d0',
          modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          phoneNumber: '087632523634',
          postalCode: '22766',
          streetName: 'Washingtonallee',
          name: 'helmut',
          email: 'helmut@was.de',
          city: 'murcia(easter egg)',
          streetNumber: '24'
      );
      test('calls insert with correct client', () async {
        try {
          await clientRepository.insertClient(client);
        } catch (_) {}
        verify(() => clientApiClient.insertClient(client)).called(1);
      });
    });
  });
}
