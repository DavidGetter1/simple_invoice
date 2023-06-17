import 'package:bl_objects_repository/invoice/repository.dart';
import 'package:easyinvoice/bl_objects/item/mutate/item_modify_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/clients/models/client.dart';
import 'package:invoice_api_client/invoices/models/invoice.dart';
import 'package:invoice_api_client/items/models/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_modify_cubit.g.dart';
part 'invoice_modify_states.dart';

class InvoiceModifyCubit extends HydratedCubit<InvoiceModifyState> {
  InvoiceModifyCubit(this._invoiceRepository) : super(InitialState()) {}

  final InvoiceRepository _invoiceRepository;

  late Client client;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController taxController = TextEditingController();
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
    print("In validateTitle");
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

  Future<void> insertInvoice() async {
    print("inserting invoice...");
    emit(LoadingState());
    try {
      // Invoice data = Invoice(
      //     title: titleController.text,
      //     description: descriptionController.text,
      //     pricePerUnit: double.parse(priceController.text),
      //     discount: double.parse(discountController.text),
      //     tax: double.parse(discountController.text),
      //     id: '',
      //     userId: '');
      // await _invoiceRepository.insert(data);
      emit(InvoiceModifiedState(id: id, items: []));
      print("invoice created");
    } on Exception catch (e) {
      print(e.toString());
      emit(FailureState(errorMessage: e.toString()));
    }
  }

  Future<void> updateInvoice(Invoice invoice) async {
    emit(LoadingState());
    if (invoice.id == null) {
      emit(const FailureState(
          errorMessage: "can not update invoice without id"));
    }
    try {
      // Invoice data = Invoice(
      //     title: titleController.text,
      //     description: descriptionController.text,
      //     pricePerUnit: double.parse(priceController.text),
      //     discount: double.parse(discountController.text),
      //     tax: double.parse(discountController.text),
      //     id: invoice.id,
      //     userId: invoice.userId);
      // await _invoiceRepository.update(data);
      emit(InvoiceModifiedState(id: invoice.id!, items: []));
    } on Exception catch (e) {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> deleteInvoice(String? id) async {
    if (id == null || id.isEmpty) return;

    emit(LoadingState());
    try {
      await _invoiceRepository.delete(id);
      emit(InvoiceModifiedState(id: id, items: []));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return InvoiceModifiedState.fromJson(json);
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

  void initControllersFromInvoice(Invoice? invoice) {
    if (invoice == null) return;
    //  titleController.text = invoice.title;
    //  descriptionController.text = invoice.description ?? "";
    //  priceController.text = invoice.pricePerUnit.toString();
    //  discountController.text = invoice.discount.toString();
    //  taxController.text = invoice.tax.toString();
  }

  void resetControllers() {
    titleController.text = "";
    descriptionController.text = "";
    priceController.text = "0";
    discountController.text = "0";
    taxController.text = "0";
  }
}
