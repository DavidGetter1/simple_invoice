import 'package:authentication/authentication.dart';
import 'package:bl_objects_repository/item/models/item.dart';
import 'package:bl_objects_repository/item/repository.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/items/models/itemDTO.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item_modify_cubit.g.dart';
part 'item_modify_states.dart';

class ItemModifyCubit extends HydratedCubit<ItemModifyState> {
  ItemModifyCubit(this._itemRepository) : super(InitialState()) {}

  final ItemRepository _itemRepository;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController taxController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final unfocusNode = FocusNode();

  String? validateDiscount(String? value) {
    if (value == null) {
      return 'Please make an input';
    }
    if (value.isEmpty) {
      return 'Discount is required.';
    }
    if (value.length < 1) {
      return 'Discount must be at least 1 characters long.';
    }
    double discount = double.parse(value);
    if (discount < 0 || discount > 100) {
      return 'Discount must be between 0 and 100';
    }
    return null;
  }

  String? validateTax(String? value) {
    if (value == null) {
      return 'Please make an input';
    }
    if (value.isEmpty) {
      return 'Tax is required.';
    }
    if (value.length < 1) {
      return 'Tax must be at least 1 characters long.';
    }
    double tax = double.parse(value);
    if (tax < 0 || tax > 100) {
      return 'Tax must be between 0 and 100';
    }
    return null;
  }

  String? validateTitle(String? value) {
    if (value == null) {
      return 'Please make an input';
    }
    if (value.isEmpty) {
      return 'Title is required.';
    }
    if (value.length < 3) {
      return 'Title must be at least 3 characters long.';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null) {
      return 'Please make an input';
    }
    if (value.isEmpty) {
      return 'Price is required.';
    }
    if (value.length < 1) {
      return 'Price must be at least 1 characters long.';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null) {
      return 'Please make an input';
    }
    if (value.isEmpty) {
      return 'Description is required.';
    }
    if (value.length < 3) {
      return 'Description must be at least 3 characters long.';
    }
    return null;
  }

  Future<void> insertItem() async {
    print("inserting item...");
    emit(LoadingState());
    try {
      final String id = await _itemRepository.insertItem(
          title: titleController.text,
          description: descriptionController.text,
          pricePerUnit: double.parse(priceController.text),
          discount: double.parse(discountController.text),
          tax: double.parse(discountController.text));
      emit(ItemModifiedState(id: id));
      print("item created");
    } on Exception catch (e) {
      print(e.toString());
      emit(FailureState(errorMessage: e.toString()));
    }
  }

  Future<void> updateItem(Item item) async {
    emit(LoadingState());
    if (item.id == null) {
      emit(const FailureState(errorMessage: "can not update item without id"));
    }
    try {
      await _itemRepository.updateItem(
          id: item.id!,
          title: titleController.text,
          description: descriptionController.text,
          pricePerUnit: double.parse(priceController.text),
          discount: double.parse(discountController.text),
          tax: double.parse(discountController.text));

      emit(ItemModifiedState(id: id));
    } on Exception catch (e) {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> deleteItem(String? id) async {
    if (id == null || id.isEmpty) return;

    emit(LoadingState());
    try {
      await _itemRepository.deleteItem(id);
      emit(ItemModifiedState(id: id));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return ItemModifiedState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(state) {
    return state.toJson();
  }

  dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
  }

  void initControllersFromItem(Item? item) {
    if (item == null) return;
    titleController.text = item.title;
    descriptionController.text = item.description ?? "";
    priceController.text = item.pricePerUnit.toString();
    discountController.text = item.discount.toString();
    taxController.text = item.tax.toString();
  }

  void resetControllers() {
    titleController.text = "";
    descriptionController.text = "";
    priceController.text = "0";
    discountController.text = "0";
    taxController.text = "0";
  }
}
