import 'package:authentication/authentication.dart';
import 'package:bl_objects_repository/item/models/item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bl_objects_repository/item/index.dart'
    show ItemRepository, ItemResponse;
part 'item_cubit.g.dart';
part 'item_state.dart';

class ItemCubit extends HydratedCubit<ItemState> {
  ItemCubit(this._itemRepository) : super(InitialState()) {}

  final ItemRepository _itemRepository;
  int _skip = 0;

  @visibleForTesting
  int get skip => _skip;

  @visibleForTesting
  List<Item> get itemList => _itemList;

  List<Item> get _itemList => _itemRepository.getItemList();

  Future<void> refreshItemList() async {
    emit(LoadingState());
    try {
      emit(OperationCompletedState(itemList: _itemList));
    } on Exception catch (e) {
      emit(FailureState(errorMessage: e.toString()));
    }
  }

  Future<void> fetchItem(String? id) async {
    if (id == null || id.isEmpty) return;

    emit(LoadingState());

    try {
      final item = await _itemRepository.getItem(id);

      emit(ItemFetchedState(item: item));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> fetchItems(
      {Map<String, String>? query, bool pagination = false}) async {
    if (query == null) query = {};
    query['skip'] = '$_skip';
    emit(LoadingState());
    if (!pagination) {
      _skip = 0;
    }
    try {
      final int oldLengthItemList = _itemList.length;
      _skip = await _itemRepository.getItems(query, pagination);
      if (_itemList.length == oldLengthItemList) {
        emit(NoMoreResultsState());
        return;
      }
      emit(OperationCompletedState(itemList: _itemList));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  //TODO where is OperationComplete state?

  @override
  ItemState? fromJson(Map<String, dynamic> json) {
    switch (json["state"]) {
      case "InitialState":
        return InitialState();
      case "LoadingState":
        return LoadingState();
      case "ItemFetchedState":
        return ItemFetchedState.fromJson(json["class"]);
      case "FailureState":
        return FailureState.fromJson(json["class"]);
    }
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(ItemState state) {
    switch (state.runtimeType) {
      case ItemFetchedState:
        return {
          "state": "ItemFetchedState",
          "class": (state as ItemFetchedState).toJson()
        };
      case InitialState:
        return {"state": "InitialState"};
      case LoadingState:
        return {"state": "LoadingState"};
      case FailureState:
        return {
          "state": "FailureState",
          "class": (state as FailureState).toJson()
        };
      default:
        return {};
    }
  }
}
