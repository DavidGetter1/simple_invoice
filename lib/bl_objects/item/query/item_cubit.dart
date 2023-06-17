import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bl_objects_repository/item/index.dart' show ItemRepository;
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

  List<Item> get _itemList => _itemRepository.entityList;

  void setItemList(List<Item> itemList) {
    _itemRepository.setList(itemList);
  }

  Future<void> refreshItemList() async {
    print('refreshItemList: $_skip');
    emit(LoadingState());
    try {
      emit(OperationCompletedState(itemList: _itemList));
    } on Exception catch (e) {
      emit(FailureState(errorMessage: e.toString()));
    }
  }

  Future<void> fetchItem(String? id) async {
    print('fetchItem: $id');
    if (id == null || id.isEmpty) return;

    emit(LoadingState());

    try {
      final item = await _itemRepository.get(id);

      emit(ItemFetchedState(item: item));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> fetchItems(
      {Map<String, String>? query, bool pagination = false}) async {
    print('fetchItems: $_skip');
    if (query == null) query = {};
    query['skip'] = '$_skip';
    emit(LoadingState());
    if (!pagination) {
      _skip = 0;
    }
    await _itemRepository.getByQuery(query, pagination);
    try {
      final int oldLengthItemList = _itemList.length;

      if (_itemList.length == oldLengthItemList) {
        emit(NoMoreResultsState());
        return;
      }
      emit(OperationCompletedState(itemList: _itemList));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  @override
  ItemState? fromJson(Map<String, dynamic> json) {
    print("restoring state: ${json["state"]}");
    switch (json["state"]) {
      case "InitialState":
        return InitialState();
      case "LoadingState":
        return LoadingState();
      case "ItemFetchedState":
        return ItemFetchedState.fromJson(json["class"]);
      case "FailureState":
        return FailureState.fromJson(json["class"]);
      case "OperationCompletedState":
        OperationCompletedState operationCompletedState =
            OperationCompletedState.fromJson(json["class"]);
        setItemList(operationCompletedState.itemList);
        return OperationCompletedState.fromJson(json["class"]);
    }
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(ItemState state) {
    print("persisting state: ${state.runtimeType}");
    if (state is OperationCompletedState)
      print("list length: ${state.itemList.length}");
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
      case OperationCompletedState:
        return {
          "state": "OperationCompletedState",
          "class": (state as OperationCompletedState).toJson()
        };
      default:
        return {};
    }
  }
}
