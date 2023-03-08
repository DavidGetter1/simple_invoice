import 'dart:async';

import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:invoice_api_client/items/models/itemDTOSend.dart';

import 'models/itemResponse.dart';

class ItemFailure implements Exception {}

class ItemRepository {
  ItemRepository({ItemApiClient? itemApiClient})
      : _itemApiClient = itemApiClient ?? ItemApiClient();

  final ItemApiClient _itemApiClient;

  Future<ItemDTOReceive> getItem(String id) async {
    ItemDTOReceive item = await _itemApiClient.getItemById(id);
    return item;
  }

  Future<ItemResponse> getItems(Map<String, String> query) async {
    Map<String, dynamic> responseMap = await _itemApiClient.getItems(query);
    ItemResponse itemResponse = ItemResponse(
        itemList: responseMap["itemList"], lastN: responseMap["lastN"]);
    return itemResponse;
  }

  deleteItem(String id) async {
    await _itemApiClient.deleteItem(id);
  }

  Future<String> insertItem({
    required String userId,
    required String title,
    required double pricePerUnit,
    required String description,
    required double tax,
    required double discount,
    required bool taxIncluded,
    required double taxedAmount,
  }) async {
    final item = ItemDTOSend(
      userId: userId,
      title: title,
      pricePerUnit: pricePerUnit,
      description: description,
      tax: tax,
      discount: discount,
      taxIncluded: taxIncluded,
      taxedAmount: taxedAmount,
    );
    String insertedId = await _itemApiClient.insertItem(item);
    return insertedId;
  }

  updateItem(ItemDTOReceive item) async {
    await _itemApiClient.updateItem(item);
  }
}
