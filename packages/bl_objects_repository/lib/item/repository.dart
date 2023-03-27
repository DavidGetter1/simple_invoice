import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:authentication/authentication.dart';

import 'models/item.dart';

class ItemFailure implements Exception {}

class ItemRepository {
  ItemRepository({ItemApiClient? itemApiClient})
      : _itemApiClient = itemApiClient ?? ItemApiClient() {}

  late AuthenticationRepository _authenticationRepository;

  void setAuthenticationRepository(
      AuthenticationRepository authenticationRepository) {
    _authenticationRepository = authenticationRepository;
    _authenticationRepository.userId.listen(_onUserIdChanged);
  }

  String _userId = "uninitialized";

  void _onUserIdChanged(String id) {
    _userId = id;
    getItems({}, false);
  }

  final ItemApiClient _itemApiClient;

  Future<Item> getItem(String id) async {
    ItemDTO item = await _itemApiClient.getItemById(id);
    Item transformedItem = Item.fromItemDTO(item);
    return transformedItem;
  }

  @visibleForTesting
  void setItemList(List<Item> itemList) {
    _itemList = itemList;
  }

  List<Item> _itemList = [];

  List<Item> getItemList() {
    return _itemList;
  }

  Future<bool> deleteItem(String id) async {
    try {
      await _itemApiClient.deleteItem(id);
      _itemList.removeWhere((item) => item.id == id);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<int> getItems(Map<String, String> query, pagination) async {
    print('getItems called with query: $query, pagination: $pagination');

    query['user_id'] = _userId;
    if (!pagination) {
      _itemList.clear();
    }
    try {
      ItemResponse itemResponse = await _itemApiClient.getItems(query);
      _itemList.addAll(itemResponse.itemList.map((e) => Item.fromItemDTO(e)));
      return itemResponse.lastN;
    } catch (e) {
      return 0;
    }
  }

  Future<String> insertItem(
      {required String title,
      double? pricePerUnit,
      String? description,
      double? tax,
      double? discount}) async {
    final item = ItemDTO(
        userId: _userId,
        title: title,
        pricePerUnit: pricePerUnit,
        description: description,
        tax: tax,
        discount: discount);
    String insertedId = await _itemApiClient.insertItem(item);
    //here i can be sure, that the response was 201

    _itemList.add(Item.fromItemDTO(item));
    return insertedId;
  }

  updateItem(
      {required String id,
      required String title,
      double? pricePerUnit,
      String? description,
      double? tax,
      double? discount}) async {
    final item = ItemDTO(
        id: id,
        title: title,
        pricePerUnit: pricePerUnit,
        description: description,
        tax: tax,
        discount: discount);
    await _itemApiClient.updateItem(item);
    int index = _itemList.indexWhere((element) => element.id == id);
    _itemList.replaceRange(index, index + 1, [Item.fromItemDTO(item)]);
  }
}
