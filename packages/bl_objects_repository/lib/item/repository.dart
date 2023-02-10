import 'dart:async';

import 'package:invoice_api_client/invoice_api_client.dart';

import 'models/itemResponse.dart';

class ItemFailure implements Exception {}

class ItemRepository {
  ItemRepository({ItemApiClient? itemApiClient})
      : _itemApiClient = itemApiClient ?? ItemApiClient();

  final ItemApiClient _itemApiClient;

  Future<Item> getItem(String id) async{
    Item item = await _itemApiClient.getItemById(id);
    return item;
  }

  Future<ItemResponse> getItems(Map<String, String> query) async{
    Map<String, dynamic> responseMap = await _itemApiClient.getItems(query);
    ItemResponse itemResponse = ItemResponse(itemList: responseMap["itemList"], lastN: responseMap["lastN"]);
    return itemResponse;
  }

  deleteItem(String id) async{
    await _itemApiClient.deleteItem(id);
  }

  Future<String> insertItem(Item item) async{
    String insertedId = await _itemApiClient.insertItem(item);
    return insertedId;
  }

  updateItem(Item item) async{
    await _itemApiClient.updateItem(item);
  }
}