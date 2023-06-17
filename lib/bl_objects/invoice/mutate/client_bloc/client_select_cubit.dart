import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoice_api_client/clients/models/client.dart';

// Define the states
abstract class ClientSelectState {}

class InitialState extends ClientSelectState {}

class ClientSetState extends ClientSelectState {
  final Client client;

  ClientSetState(this.client);
}

class FailedState extends ClientSelectState {
  final String errorMessage;

  FailedState(this.errorMessage);
}

class ClientSelectCubit extends Cubit<ClientSelectState> {
  ClientSelectCubit() : super(InitialState());

  void setClient(Client client) {
    emit(ClientSetState(client));
  }
}
