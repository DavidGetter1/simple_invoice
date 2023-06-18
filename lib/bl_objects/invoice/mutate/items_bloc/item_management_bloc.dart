import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_api_client/items/models/item.dart';

// ItemState represents the different states of the item management process
abstract class ItemManagementState {}

class ItemLoadingState extends ItemManagementState {}

class ItemAddedState extends ItemManagementState {
  final Item item;

  ItemAddedState(this.item);
}

class ItemDeletedState extends ItemManagementState {
  final Item item;

  ItemDeletedState(this.item);
}

class ItemManagementCubit extends Cubit<ItemManagementState> {
  List<Item> _items = [];

  List<Item> get items => _items;

  ItemManagementCubit() : super(ItemLoadingState());

  void addItem(Item item) {
    _items.add(item);
    emit(ItemAddedState(item));
  }

  void deleteItem(Item item) {
    _items.remove(item);
    emit(ItemDeletedState(item));
  }
}
