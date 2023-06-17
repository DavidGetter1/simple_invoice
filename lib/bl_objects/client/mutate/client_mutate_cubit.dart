import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/clients/models/client.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bl_objects_repository/client/index.dart'
    show Client, ClientRepository, ClientResponse;
part 'client_mutate_cubit.g.dart';
part 'client_mutate_state.dart';

class ClientMutateCubit extends HydratedCubit<ClientMutateState> {
  ClientMutateCubit(this._clientRepository) : super(InitialState());

  final ClientRepository _clientRepository;
  final unfocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Email validation regular expression
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }

    return null;
  }

  Future<void> updateClient(Client client) async {
    emit(LoadingState());
    if (client.id == null) {
      emit(const FailureState(errorMessage: "can not update item without id"));
    }
    try {
      await _clientRepository.updateClient(
          id: client.id!,
          name: nameController.text,
          email: emailController.text,
          phoneNumber: phoneNumberController.text);
      emit(ClientMutatedState(id: client.id!));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> deleteClient(String? id) async {
    if (id == null || id.isEmpty) return;

    emit(LoadingState());

    try {
      await _clientRepository.deleteClient(id);
      emit(ClientMutatedState(id: id));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> insertClient() async {
    emit(LoadingState());
    try {
      final String id = await _clientRepository.insertClient(
          name: nameController.text,
          email: emailController.text,
          phoneNumber: phoneNumberController.text);
      emit(ClientMutatedState(id: id));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  @override
  ClientMutateState? fromJson(Map<String, dynamic> json) {
    switch (json["state"]) {
      case "InitialState":
        return InitialState();
      case "LoadingState":
        return LoadingState();
      case "ClientMutatedState":
        return ClientMutatedState.fromJson(json["class"]);
      case "FailureState":
        return FailureState.fromJson(json["class"]);
    }
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(ClientMutateState state) {
    switch (state.runtimeType) {
      case InitialState:
        return {"state": "InitialState"};
      case LoadingState:
        return {"state": "LoadingState"};
      case ClientMutatedState:
        return {"state": "ClientMutatedState"};
      case FailureState:
        return {
          "state": "FailureState",
          "class": (state as FailureState).toJson()
        };
      default:
        return {};
    }
  }

  void resetControllers() {
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
  }

  void initControllerFromClient(client) {
    if (client == null) return;
    nameController.text = client.name;
    emailController.text = client.email;
    phoneNumberController.text = client.phoneNumber;
  }
}
