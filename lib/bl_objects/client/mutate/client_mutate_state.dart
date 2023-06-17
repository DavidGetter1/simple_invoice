part of 'client_mutate_cubit.dart';

abstract class ClientMutateState extends Equatable {
  const ClientMutateState();

  @override
  List<Object?> get props => [];
}

class InitialState extends ClientMutateState {}

class LoadingState extends ClientMutateState {}

@JsonSerializable()
class ClientMutatedState extends ClientMutateState {
  final String id;
  const ClientMutatedState({required this.id});

  factory ClientMutatedState.fromJson(Map<String, dynamic> json) =>
      _$ClientCreatedStateFromJson(json);

  Map<String, dynamic> toJson() => _$ClientCreatedStateToJson(this);
}

@JsonSerializable()
class FailureState extends ClientMutateState {
  final String errorMessage;
  const FailureState({required this.errorMessage});

  factory FailureState.fromJson(Map<String, dynamic> json) =>
      _$FailureStateFromJson(json);

  Map<String, dynamic> toJson() => _$FailureStateToJson(this);
}
