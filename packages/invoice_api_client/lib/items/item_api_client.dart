import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:invoice_api_client/api_client/api_client.dart';
import 'package:invoice_api_client/invoice_api_client.dart';

import '../entity/entity.dart';
import '../response/response.dart';

class ItemIdRequestFailure implements Exception {
  String message;
  ItemIdRequestFailure(this.message);
}

class ItemApiClient extends ApiClient<Item> {
  ItemApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  // If you want to test it locally, then the _baseUrl is = 'localhost:5001' for example
  // otherwise for deployment its us-central1-invoice-c63dc.cloudfunctions.net
  // also if you doing it locally, change the Uri.https to http if needed.
  // the path looks like this then: '/invoice-c63dc/us-central1/ms_bl_objects/v1/bl_objects/item
  // when deploying its simply 'api/v1/bl_objects/item'
  // dont forget to adjust http correctly
  static const _baseUrl =
      '192.168.2.110:5001/invoice-c63dc/us-central1/ms_bl_objects';
  final http.Client _httpClient;

  /**
   * Deletes an [ItemReceive] by ID.
   */
  @override
  delete(String id) async {
    final itemRequest = Uri.parse(
      'http://' + _baseUrl + '/v1/bl_objects/item/$id',
    );
    final itemResponse = await _httpClient.delete(itemRequest);
    print(itemResponse.body);
    if (itemResponse.statusCode != 200) {
      throw Exception(itemResponse.body);
    }

    final itemJson = jsonDecode(itemResponse.body);

    if (itemJson["deletedCount"] != 1) {
      throw new Exception('No items deleted');
    }
  }

  /**
   * Fetches an [ItemReceive] by ID.
   */
  @override
  dynamic getById(String id) async {
    final itemRequest = Uri.parse(
      'http://' + _baseUrl + '/api/v1/bl_objects/item/$id',
    );
    final itemResponse = await _httpClient.get(itemRequest);

    if (itemResponse.statusCode != 200) {
      throw ItemIdRequestFailure(itemResponse.body.toString());
    }
    final itemJson = jsonDecode(itemResponse.body);
    if (itemJson == {}) {
      throw new Exception('No items found');
    }

    try {
      Item item = Item.fromJson(itemJson as Map<String, dynamic>);
      return item;
    } catch (e) {
      print("error in getItemById");
      print(e.toString());
    }
  }

  /**
   * Queries the DB for items.
   */
  @override
  dynamic get(Map<String, String> query) async {
    String stringifiedQuery = Uri(queryParameters: query).query;

    final itemRequest = Uri.parse(
        'http://' + _baseUrl + '/v1/bl_objects/item?$stringifiedQuery');

    print("hey im fetching items");
    final itemResponse = await _httpClient.get(itemRequest);

    print(itemResponse.body);

    if (itemResponse.statusCode != 200) {
      throw new Exception(itemResponse.body);
    }
    final itemJson = jsonDecode(itemResponse.body);
    if (itemJson["data"].isEmpty) {
      throw new Exception('No items found');
    }
    try {
      List<Item> itemList = List<Item>.from(
          itemJson["data"].map((item) => Item.fromJson(item)).toList());
      return Response<Item>(list: itemList, lastN: itemJson["lastN"]);
    } catch (e) {
      print("error in getItems");

      print(e.toString());
    }
  }

  /**
   * Inserts the [ItemReceive] into the DB.
   */
  @override
  insert(Item item) async {
    print(item.toJson());
    final itemRequest = Uri.parse('http://' + _baseUrl + '/v1/bl_objects/item');
    String itemJson = jsonEncode(item.toJson());
    final itemResponse = await _httpClient.post(itemRequest,
        body: itemJson, headers: {"Content-Type": "application/json"});
    print(itemResponse);
    if (itemResponse.statusCode != 201) {
      throw Exception(itemResponse.body);
    }
    final decodedResponse = jsonDecode(itemResponse.body);
    return decodedResponse["insertedId"];
  }

  /**
   * Inserts the [ItemReceive] into the DB.
   */
  @override
  update(Item item) async {
    final itemRequest = Uri.parse('http://' + _baseUrl + '/v1/bl_objects/item');
    print(item.toJson());
    String itemJson = jsonEncode(item.toJson());
    print("sending: " + itemJson);
    final itemResponse = await _httpClient.put(itemRequest,
        body: itemJson, headers: {"Content-Type": "application/json"});
    print(itemResponse.body);
    if (itemResponse.statusCode != 200) {
      throw Exception(itemResponse.body);
    }

    final responseJson = jsonDecode(itemResponse.body);
    final bool updated = responseJson["modifiedCount"] == 1;
    if (!updated) {
      throw new Exception('No items updated');
    }
  }
}
