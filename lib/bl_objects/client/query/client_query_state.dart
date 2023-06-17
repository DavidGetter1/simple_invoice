part of 'client_query_cubit.dart';

abstract class ClientQueryState extends Equatable {
  const ClientQueryState();

  @override
  List<Object?> get props => [];
}

class InitialState extends ClientQueryState {}

class LoadingState extends ClientQueryState {}

class NoMoreResultsState extends ClientQueryState {}

@JsonSerializable(explicitToJson: true)
class ClientFetchedState extends ClientQueryState {
  final Client client;
  const ClientFetchedState({required this.client});

  factory ClientFetchedState.fromJson(Map<String, dynamic> json) =>
      _$ClientFetchedStateFromJson(json);

  Map<String, dynamic> toJson() => _$ClientFetchedStateToJson(this);

  @override
  List<Object?> get props => [client];
}

@JsonSerializable(explicitToJson: true)
class OperationCompletedState extends ClientQueryState {
  final List<Client> clientList;
  const OperationCompletedState({required this.clientList});

  factory OperationCompletedState.fromJson(Map<String, dynamic> json) =>
      _$ClientListFetchedStateFromJson(json);

  Map<String, dynamic> toJson() => _$ClientListFetchedStateToJson(this);

  @override
  List<Object?> get props => [clientList];
}

@JsonSerializable()
class FailureState extends ClientQueryState {
  final String errorMessage;
  const FailureState({required this.errorMessage});

  factory FailureState.fromJson(Map<String, dynamic> json) =>
      _$FailureStateFromJson(json);

  Map<String, dynamic> toJson() => _$FailureStateToJson(this);
}
