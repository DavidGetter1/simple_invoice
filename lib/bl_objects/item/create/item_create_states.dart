part of 'item_create_cubit.dart';

abstract class ItemCreateState extends Equatable {
  const ItemCreateState();

  @override
  List<Object?> get props => [];
}

class InitialState extends ItemCreateState {}

class LoadingState extends ItemCreateState {}

@JsonSerializable()
class ItemCreatedState extends ItemCreateState{

  final String id;
  const ItemCreatedState({required this.id});

  factory ItemCreatedState.fromJson(Map<String, dynamic> json) =>
      _$ItemCreatedStateFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCreatedStateToJson(this);
}

@JsonSerializable()
class FailureState extends ItemCreateState {
  final String errorMessage;
  const FailureState({required this.errorMessage});

  factory FailureState.fromJson(Map<String, dynamic> json) =>
      _$FailureStateFromJson(json);

  Map<String, dynamic> toJson() => _$FailureStateToJson(this);
}

