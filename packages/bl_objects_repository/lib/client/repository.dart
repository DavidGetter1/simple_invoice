import 'dart:async';

import 'package:authentication/authentication.dart';
import 'package:invoice_api_client/clients/models/client.dart';
import 'package:invoice_api_client/clients/models/client_response.dart';
import 'package:invoice_api_client/complementary_models/address.dart';
import 'package:invoice_api_client/invoice_api_client.dart';

class ClientFailure implements Exception {}

class ClientRepository {
  ClientRepository({ClientApiClient? clientApiClient})
      : _clientApiClient = clientApiClient ?? ClientApiClient();

  final ClientApiClient _clientApiClient;

  List<Client> _clientList = [];

  List<Client> getClientList() {
    return _clientList;
  }

  late AuthenticationRepository _authenticationRepository;

  void setAuthenticationRepository(
      AuthenticationRepository authenticationRepository) {
    _authenticationRepository = authenticationRepository;
    _authenticationRepository.userId.listen(_onUserIdChanged);
  }

  void _onUserIdChanged(String id) {
    print('old id: $_userId, new id: $id');
    if (_userId == id) {
    } else {
      print("ClientRepository: _onUserIdChanged($id)");
      _userId = id;
      getClients({}, false);
    }
  }

  String _userId = "uninitialized";

  Future<Client> getClient(String id) async {
    Client client = await _clientApiClient.getClientById(id);
    return client;
  }

  Future<int> getClients(Map<String, String> query, bool pagination) async {
    query['user_id'] = _userId;
    if (!pagination) {
      _clientList.clear();
    }
    try {
      ClientResponse clientResponse = await _clientApiClient.getClients(query);
      _clientList.addAll(clientResponse.clientList);
      return clientResponse.lastN;
    } on Exception {
      return 0;
    }
  }

  Future<bool> deleteClient(String id) async {
    try {
      await _clientApiClient.deleteClient(id);
      _clientList.removeWhere((client) => client.id == id);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<String> insertClient({
    String? name,
    Address? address,
    String? phoneNumber,
    String? email,
  }) async {
    Client client = Client(
      userId: _userId,
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      email: email,
    );
    String insertedId = await _clientApiClient.insertClient(client);
    _clientList.add(client);
    return insertedId;
  }

  updateClient({
    required String id,
    String? name,
    Address? address,
    String? phoneNumber,
    String? email,
  }) async {
    Client client = Client(
      id: id,
      name: name,
      address: address,
      phoneNumber: phoneNumber,
      email: email,
    );
    await _clientApiClient.updateClient(client);
    int index = _clientList.indexWhere((element) => element.id == id);
    _clientList.replaceRange(index, index + 1, [client]);
  }
}
