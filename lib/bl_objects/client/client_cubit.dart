import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bl_objects_repository/client/index.dart'
    show ClientRepository, ClientResponse;
part 'client_cubit.g.dart';
part 'client_state.dart';

class ClientCubit extends HydratedCubit<ClientState> {
  ClientCubit(this._clientRepository): super(InitialState());

  final ClientRepository _clientRepository;
  List<Client> _clientList = [];
  int _skip = 0;

  Future<void> updateClient(Client client) async {

    emit(LoadingState());

    try {
      await _clientRepository.updateClient(client);
      emit(ClientUpdatedState());
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
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

  Future<void> deleteClient(String? id) async {
    if (id == null || id.isEmpty) return;

    emit(LoadingState());

    try {
      await _clientRepository.deleteClient(id);
      emit(ClientDeletedState());
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> fetchClients({Map<String, String>? query = const {}, bool pagination = false}) async {
    if (query == null) return;
    query['skip'] = '$_skip';
    emit(LoadingState());
    if(!pagination){
      _skip = 0;
      _clientList = [];
    }
    try {
      ClientResponse response = await _clientRepository.getClients(query);
      if(pagination){
        _skip = response.lastN;
      }
      if(response.clientList.isEmpty){
        emit(NoMoreResultsState());
        return;
      }
      _clientList += response.clientList;
      emit(ClientListFetchedState(clientList: _clientList, lastN: response.lastN));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> insertClient(Client client) async {

    emit(LoadingState());

    try {
      final String id = await _clientRepository.insertClient(client);

      emit(ClientCreatedState(id: id));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  @override
  ClientState? fromJson(Map<String, dynamic> json) {
    switch (json["state"]){
      case "InitialState": return InitialState();
      case "LoadingState": return LoadingState();
      case "ClientDeletedState": return ClientDeletedState();
      case "ClientUpdatedState": return ClientUpdatedState();
      case "ClientFetchedState": return ClientFetchedState.fromJson(json["class"]);
      case "ClientCreatedState": return ClientCreatedState.fromJson(json["class"]);
      case "ClientListFetchedState": return ClientListFetchedState.fromJson(json["class"]);
      case "FailureState": return FailureState.fromJson(json["class"]);
    }
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(ClientState state) {
    switch (state.runtimeType){
      case ClientCreatedState : return {"state": "ClientCreatedState", "class": (state as ClientCreatedState).toJson()};
      case ClientFetchedState : return {"state": "ClientFetchedState", "class": (state as ClientFetchedState).toJson()};
      case ClientListFetchedState : return {"state": "ClientListFetchedState", "class":(state as ClientListFetchedState).toJson()};
      case InitialState : return {"state": "InitialState"};
      case LoadingState : return {"state": "LoadingState"};
      case ClientDeletedState : return {"state": "ClientDeletedState"};
      case ClientUpdatedState : return {"state": "ClientUpdatedState"};
      case FailureState : return {"state": "FailureState", "class":(state as FailureState).toJson()};

      default : return {};
    }
  }
}
