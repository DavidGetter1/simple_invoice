import 'dart:async';

import 'package:invoice_api_client/invoice_api_client.dart';

import 'models/clientResponse.dart';

class ClientFailure implements Exception {}

class ClientRepository {
  ClientRepository({ClientApiClient? clientApiClient})
      : _clientApiClient = clientApiClient ?? ClientApiClient();

  final ClientApiClient _clientApiClient;

  Future<Client> getClient(String id) async{
    Client client = await _clientApiClient.getClientById(id);
    return client;
  }

  Future<ClientResponse> getClients(Map<String, String> query) async{
    Map<String, dynamic> responseMap = await _clientApiClient.getClients(query);
    ClientResponse clientResponse = ClientResponse(clientList: responseMap["clientList"], lastN: responseMap["lastN"]);
    return clientResponse;
  }

  deleteClient(String id) async{
    await _clientApiClient.deleteClient(id);
  }

  Future<String> insertClient(Client client) async{
    String insertedId = await _clientApiClient.insertClient(client);
    return insertedId;
  }

  updateClient(Client client) async{
    await _clientApiClient.updateClient(client);
  }
}