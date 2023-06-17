import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/clients/models/client.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bl_objects_repository/client/index.dart' show ClientRepository;
part 'client_query_cubit.g.dart';
part 'client_query_state.dart';

class ClientQueryCubit extends HydratedCubit<ClientQueryState> {
  ClientQueryCubit(this._clientRepository) : super(InitialState()) {}

  final ClientRepository _clientRepository;
  List<Client> get _clientList => _clientRepository.getClientList();
  int _skip = 0;

  Future<void> refreshClientList() async {
    emit(LoadingState());
    try {
      emit(OperationCompletedState(clientList: _clientList));
    } on Exception catch (e) {
      emit(FailureState(errorMessage: e.toString()));
    }
  }

  Future<void> fetchClient(String? id) async {
    if (id == null || id.isEmpty) return;
    emit(LoadingState());
    try {
      final client = await _clientRepository.getClient(id);
      emit(ClientFetchedState(client: client));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> fetchClients(
      {Map<String, String>? query, bool pagination = false}) async {
    if (query == null) query = {};
    query['skip'] = '$_skip';
    emit(LoadingState());
    if (!pagination) {
      _skip = 0;
    }
    try {
      final int oldLengthClientList = _clientList.length;
      _skip = await _clientRepository.getClients(query, pagination);
      if (_clientList.length == oldLengthClientList) {
        emit(NoMoreResultsState());
        return;
      }
      emit(OperationCompletedState(clientList: _clientList));
    } on Exception catch (e) {
      emit(FailureState(errorMessage: e.toString()));
    }
  }

  @override
  ClientQueryState? fromJson(Map<String, dynamic> json) {
    switch (json["state"]) {
      case "InitialState":
        return InitialState();
      case "LoadingState":
        return LoadingState();
      case "ClientFetchedState":
        return ClientFetchedState.fromJson(json["class"]);
      case "ClientListFetchedState":
        return OperationCompletedState.fromJson(json["class"]);
      case "FailureState":
        return FailureState.fromJson(json["class"]);
    }
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(ClientQueryState state) {
    switch (state.runtimeType) {
      case ClientFetchedState:
        return {
          "state": "ClientFetchedState",
          "class": (state as ClientFetchedState).toJson()
        };
      case OperationCompletedState:
        return {
          "state": "ClientListFetchedState",
          "class": (state as OperationCompletedState).toJson()
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
