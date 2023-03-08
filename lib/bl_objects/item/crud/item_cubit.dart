import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bl_objects_repository/item/index.dart'
    show ItemRepository, ItemResponse;
part 'item_cubit.g.dart';
part 'item_state.dart';

class ItemCubit extends HydratedCubit<ItemState> {
  ItemCubit(this._itemRepository): super(InitialState());


  //was machen mit itemList so wie beim client_cubit und test schreiben
  final ItemRepository _itemRepository;
  List<ItemDTOReceive> _itemList = [];
  int _skip = 0;

  Future<void> updateItem(ItemDTOReceive item) async {

    emit(LoadingState());

    try {
      await _itemRepository.updateItem(item);

      emit(ItemUpdatedState());
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
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

  Future<void> deleteItem(String? id) async {
    if (id == null || id.isEmpty) return;

    emit(LoadingState());

    try {
      await _itemRepository.deleteItem(id);
      emit(ItemDeletedState());
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> fetchItems({Map<String, String>? query = const {}, bool pagination = false}) async {
    if (query == null) return;
    query['skip'] = '$_skip';
    emit(LoadingState());
    if(!pagination){
      _skip = 0;
      _itemList = [];
    }
    try {
      ItemResponse response = await _itemRepository.getItems(query);
      if(pagination){
        _skip = response.lastN;
      }
      if(response.itemList.isEmpty){
        emit(NoMoreResultsState());
        return;
      }
      _itemList += response.itemList;
      emit(ItemListFetchedState(itemList: _itemList, lastN: response.lastN));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  @override
  ItemState? fromJson(Map<String, dynamic> json) {
    switch (json["state"]){
      case "InitialState": return InitialState();
      case "LoadingState": return LoadingState();
      case "ItemDeletedState": return ItemDeletedState();
      case "ItemUpdatedState": return ItemUpdatedState();
      case "ItemFetchedState": return ItemFetchedState.fromJson(json["class"]);
      case "ItemCreatedState": return ItemCreatedState.fromJson(json["class"]);
      case "ItemListFetchedState": return ItemListFetchedState.fromJson(json["class"]);
      case "FailureState": return FailureState.fromJson(json["class"]);
    }
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(ItemState state) {
    switch (state.runtimeType){
      case ItemCreatedState : return {"state": "ItemCreatedState", "class": (state as ItemCreatedState).toJson()};
      case ItemFetchedState : return {"state": "ItemFetchedState", "class": (state as ItemFetchedState).toJson()};
      case ItemListFetchedState : return {"state": "ItemListFetchedState", "class":(state as ItemListFetchedState).toJson()};
      case InitialState : return {"state": "InitialState"};
      case LoadingState : return {"state": "LoadingState"};
      case ItemDeletedState : return {"state": "ItemDeletedState"};
      case ItemUpdatedState : return {"state": "ItemUpdatedState"};
      case FailureState : return {"state": "FailureState", "class":(state as FailureState).toJson()};

      default : return {};
    }
  }
}
