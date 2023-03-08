import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:invoice_api_client/invoice_api_client.dart';

import 'models/itemDTOSend.dart';

/// Exception thrown when locationSearch fails.
class ItemIdRequestFailure implements Exception {
  String message;
  ItemIdRequestFailure(this.message);
}

/// {@template meta_weather_api_client}
/// Dart API Client which wraps the [MetaWeather API](http://www.metaweather.com/api/).
/// {@endtemplate}
class ItemApiClient {
  /// {@macro meta_weather_api_client}
  ItemApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();
  // If you want to test it locally, then the _baseUrl is = 'localhost:5001' for example
  // otherwise for deployment its us-central1-invoice-c63dc.cloudfunctions.net
  // also if you doing it locally, change the Uri.https to http if needed.
  // the path looks like this then: '/invoice-c63dc/us-central1/ms_bl_objects/v1/bl_objects/item
  // when deploying its simply 'api/v1/bl_objects/item'
  // dont forget to adjust http correctly
  static const _baseUrl = 'us-central1-invoice-c63dc.cloudfunctions.net';
  final http.Client _httpClient;

  /**
   * Deletes an [ItemDTOReceive] by ID.
   */
  deleteItem(String id) async {
    final itemRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/item/$id',
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
   * Fetches an [ItemDTOReceive] by ID.
   */
  dynamic getItemById(String id) async {
    print("fetching");
    final itemRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/item/$id',
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
      ItemDTOReceive item =
          ItemDTOReceive.fromJson(itemJson as Map<String, dynamic>);
      return item;
    } catch (e) {
      print(e.toString());
    }
  }

  /**
   * Queries the DB for items.
   */
  dynamic getItems(Map<String, String> query) async {
    jsonEncode(query);
    final itemRequest = Uri.https(_baseUrl, '/api/v1/bl_objects/item', query);
    final itemResponse = await _httpClient.get(itemRequest);
    if (itemResponse.statusCode != 200) {
      throw new Exception(itemResponse.body);
    }

    final itemJson = jsonDecode(itemResponse.body);
    if (itemJson["data"].isEmpty) {
      throw new Exception('No items found');
    }
    try {
      List<ItemDTOReceive> itemList = List<ItemDTOReceive>.from(itemJson["data"]
          .map((item) => ItemDTOReceive.fromJson(item))
          .toList());
      return {"itemList": itemList, "lastN": itemJson["lastN"]};
    } catch (e) {
      print(e.toString());
    }
  }

  /**
   * Inserts the [ItemDTOReceive] into the DB.
   */
  insertItem(ItemDTOSend item) async {
    final itemRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/item',
    );
    String itemJson = jsonEncode(item.toJson());
    final itemResponse = await _httpClient.put(itemRequest,
        body: itemJson, headers: {"Content-Type": "application/json"});
    if (itemResponse.statusCode != 201) {
      throw Exception(itemResponse.body);
    }
    final decodedResponse = jsonDecode(itemResponse.body);
    return decodedResponse["upsertedId"];
  }

  /**
   * Inserts the [ItemDTOReceive] into the DB.
   */
  updateItem(ItemDTOReceive item) async {
    final itemRequest = Uri.https(
      _baseUrl,
      '/api/v1/bl_objects/item',
    );
    String itemJson = jsonEncode(item.toJson());
    final itemResponse = await _httpClient.put(itemRequest,
        body: itemJson, headers: {"Content-Type": "application/json"});
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
