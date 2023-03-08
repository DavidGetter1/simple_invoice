import 'package:bl_objects_repository/item/repository.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/items/models/itemDTOReceive.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'item_create_cubit.g.dart';
part 'item_create_states.dart';

class ItemCreateCubit extends HydratedCubit<ItemCreateState> {
  ItemCreateCubit(this._itemRepository) : super(InitialState());

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String userId = "unitialized";

  void setUserId(String id) {
    userId = id;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final unfocusNode = FocusNode();

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

  final ItemRepository _itemRepository;

  Future<void> insertItem() async {
    emit(LoadingState());
    try {
      final String id = await _itemRepository.insertItem(
          title: titleController.text,
          description: descriptionController.text,
          pricePerUnit: double.parse(priceController.text),
          discount: 0,
          tax: 0,
          taxIncluded: false,
          userId: userId,
          taxedAmount: 0);
      emit(ItemCreatedState(id: id));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
  }
}
