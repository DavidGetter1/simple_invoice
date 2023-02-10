import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/client.dart';

/// Exception thrown when locationSearch fails.
class ClientIdRequestFailure implements Exception {
  String message;
  ClientIdRequestFailure(this.message);
}

/// {@template meta_weather_api_client}
/// Dart API Client which wraps the [MetaWeather API](https://www.metaweather.com/api/).
/// {@endtemplate}
class ClientApiClient {
  /// {@macro meta_weather_api_client}
  ClientApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  // If you want to test it locally, then the _baseUrl is = 'localhost:5001' for example
  // otherwise for deployment its us-central1-invoice-c63dc.cloudfunctions.net/api
  // also if you doing it locally, change the Uri.https to http if needed.
  // the path looks like this then: '/invoice-c63dc/us-central1/ms_bl_objects/v1/bl_objects/client
  // when deploying its simply '/v1/bl_objects/client'
  static const _baseUrl = 'us-central1-invoice-c63dc.cloudfunctions.net';
  final http.Client _httpClient;

  /**
   * Deletes an [Client] by ID.
   */
  deleteClient(String id) async {
    final clientRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/client/$id',
    );
    final clientResponse = await _httpClient.delete(clientRequest);
  print(clientResponse.body);
    if (clientResponse.statusCode != 200) {
      throw Exception(clientResponse.body);
    }

    final clientJson = jsonDecode(
        clientResponse.body
    );

    if(clientJson["deletedCount"] != 1){
      throw new Exception('No clients deleted');
    }
  }

  /**
   * Fetches an [Client] by ID.
   */
  dynamic getClientById(String id) async {
    final clientRequest = Uri.https(
      _baseUrl,
        '/api/v1/bl_objects/client/$id',
    );
    final clientResponse = await _httpClient.get(clientRequest);

    if (clientResponse.statusCode != 200) {
      throw ClientIdRequestFailure(clientResponse.body.toString());
    }

    final clientJson = jsonDecode(
      clientResponse.body
    );

    if(clientJson == {}){
      throw new Exception('No clients found');
    }

    try{
    Client client = Client.fromJson(clientJson as Map<String, dynamic>);
    return client;
  }catch(e){
    print(e.toString());
    }}

  /**
   * Queries the DB for clients.
   */
  dynamic getClients(Map<String, String> query) async {
    final clientRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/client',
      query
    );
    final clientResponse = await _httpClient.get(clientRequest);
    print(clientResponse.body);
    if (clientResponse.statusCode != 200) {
      throw new Exception(clientResponse.body);
    }

    final clientJson = jsonDecode(
        clientResponse.body
    );
    if(clientJson["data"].isEmpty){
      throw new Exception('No clients found');
    }
    try{
      List<Client> clientList = List<Client>.from(clientJson["data"].map((client) => Client.fromJson(client)).toList());
      return {"clientList": clientList, "lastN": clientJson["lastN"]};
    }catch(e){
      print(e.toString());
    }}

  /**
   * Inserts the [Client] into the DB.
   */
  insertClient(Client client) async {
    final clientRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/client',
    );
    String clientJson = jsonEncode(client.toJson());
    final clientResponse = await _httpClient.put(clientRequest, body: clientJson, headers: {"Content-Type":"application/json"});
    if (clientResponse.statusCode != 201) {
      throw Exception(clientResponse.body);
    }
    final decodedResponse = jsonDecode(
        clientResponse.body
    );
    return decodedResponse ["upsertedId"];
  }

  /**
   * Inserts the [Client] into the DB.
   */
  updateClient(Client client) async {
    final clientRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/client',
    );
    String clientJson = jsonEncode(client.toJson());
    final clientResponse = await _httpClient.put(clientRequest, body: clientJson, headers: {"Content-Type":"application/json"});
    print(clientResponse.body);
    if (clientResponse.statusCode != 200) {
      throw Exception(clientResponse.body);
    }

    final responseJson = jsonDecode(
        clientResponse.body
    );
    final bool updated = responseJson["modifiedCount"] == 1;
    if(!updated){
      throw new Exception('No clients updated');
    }
  }
}
