
part of 'item_cubit.dart';

abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object?> get props => [];
}

class InitialState extends ItemState {}

class LoadingState extends ItemState {}

class ItemDeletedState extends ItemState {}

class ItemUpdatedState extends ItemState {}

class NoMoreResultsState extends ItemState {}

@JsonSerializable()
class ItemCreatedState extends ItemState{

  final String id;
  const ItemCreatedState({required this.id});

  factory ItemCreatedState.fromJson(Map<String, dynamic> json) =>
      _$ItemCreatedStateFromJson(json);

  Map<String, dynamic> toJson() => _$ItemCreatedStateToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ItemFetchedState extends ItemState {
  final ItemDTOReceive item;
  const ItemFetchedState({required this.item});

  factory ItemFetchedState.fromJson(Map<String, dynamic> json) =>
      _$ItemFetchedStateFromJson(json);

  Map<String, dynamic> toJson() => _$ItemFetchedStateToJson(this);

  @override
  List<Object?> get props => [item];
}

@JsonSerializable(explicitToJson: true)
class ItemListFetchedState extends ItemState {
  final int lastN;
  final List<ItemDTOReceive> itemList;
  const ItemListFetchedState({required this.itemList, required this.lastN});

  factory ItemListFetchedState.fromJson(Map<String, dynamic> json) =>
      _$ItemListFetchedStateFromJson(json);

  Map<String, dynamic> toJson() => _$ItemListFetchedStateToJson(this);

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

