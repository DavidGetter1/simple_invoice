part of 'item_modify_cubit.dart';

abstract class ItemModifyState extends Equatable {
  const ItemModifyState();
  Map<String, dynamic> toJson();
  factory ItemModifyState.fromJson(Map<String, dynamic> json) {
    switch (json['runtimeType'] as String) {
      case 'ItemModifiedState':
        return ItemModifiedState.fromJson(json);
      case 'FailureState':
        return FailureState.fromJson(json);
      case 'InitialState':
        return InitialState();
      case 'LoadingState':
        return LoadingState();
      default:
        return InitialState();
    }
  }
  @override
  List<Object?> get props => [];
}

class InitialState extends ItemModifyState {
  @override
  Map<String, dynamic> toJson() {
    return {"runtimeType": "InitialState"};
  }
}

class LoadingState extends ItemModifyState {
  @override
  Map<String, dynamic> toJson() {
    return {"runtimeType": "LoadingState"};
  }
}

@JsonSerializable(explicitToJson: true)
class ItemModifiedState extends ItemModifyState {
  final String id;
  const ItemModifiedState({required this.id});

  factory ItemModifiedState.fromJson(Map<String, dynamic> json) =>
      _$ItemModifiedStateFromJson(json);

  Map<String, dynamic> toJson() {
    return {"runtimeType": "ItemModifiedState", "id": id};
  }
}

@JsonSerializable(explicitToJson: true)
class FailureState extends ItemModifyState {
  final String errorMessage;
  const FailureState({required this.errorMessage});

  factory FailureState.fromJson(Map<String, dynamic> json) =>
      _$FailureStateFromJson(json);

  Map<String, dynamic> toJson() {
    return {"runtimeType": "FailureState", "errorMessage": errorMessage};
  }
}
