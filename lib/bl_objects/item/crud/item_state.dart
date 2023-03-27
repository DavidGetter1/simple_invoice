part of 'item_cubit.dart';

class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object?> get props => [];
}

class InitialState extends ItemState {}

class LoadingState extends ItemState {}

class NoMoreResultsState extends ItemState {}

@JsonSerializable(explicitToJson: true)
class ItemFetchedState extends ItemState {
  final Item item;
  const ItemFetchedState({required this.item});

  factory ItemFetchedState.fromJson(Map<String, dynamic> json) =>
      _$ItemFetchedStateFromJson(json);

  Map<String, dynamic> toJson() => _$ItemFetchedStateToJson(this);

  @override
  List<Object?> get props => [item];
}

@JsonSerializable(explicitToJson: true)
class OperationCompletedState extends ItemState {
  final List<Item> itemList;
  const OperationCompletedState({required this.itemList});

  factory OperationCompletedState.fromJson(Map<String, dynamic> json) =>
      _$OperationCompletedStateFromJson(json);

  Map<String, dynamic> toJson() => _$OperationCompletedStateToJson(this);

  @override
  List<Object?> get props => [itemList];
}

@JsonSerializable()
class FailureState extends ItemState {
  final String errorMessage;
  const FailureState({required this.errorMessage});

  factory FailureState.fromJson(Map<String, dynamic> json) =>
      _$FailureStateFromJson(json);

  Map<String, dynamic> toJson() => _$FailureStateToJson(this);
}
