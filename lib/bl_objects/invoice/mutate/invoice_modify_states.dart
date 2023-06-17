part of 'invoice_modify_cubit.dart';

abstract class InvoiceModifyState extends Equatable {
  const InvoiceModifyState();
  Map<String, dynamic> toJson();
  factory InvoiceModifyState.fromJson(Map<String, dynamic> json) {
    switch (json['runtimeType'] as String) {
      case 'InvoiceModifiedState':
        return InvoiceModifiedState.fromJson(json);
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

class InitialState extends InvoiceModifyState {
  @override
  Map<String, dynamic> toJson() {
    return {"runtimeType": "InitialState"};
  }
}

class LoadingState extends InvoiceModifyState {
  @override
  Map<String, dynamic> toJson() {
    return {"runtimeType": "LoadingState"};
  }
}

@JsonSerializable(explicitToJson: true)
class InvoiceModifiedState extends InvoiceModifyState {
  final Client? client;
  List<Item> items = [];
  final String id;
  InvoiceModifiedState({required this.id, required this.items, this.client});

  factory InvoiceModifiedState.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModifiedStateFromJson(json);

  Map<String, dynamic> toJson() {
    return {"runtimeType": "InvoiceModifiedState", "id": id};
  }
}

@JsonSerializable(explicitToJson: true)
class FailureState extends InvoiceModifyState {
  final String errorMessage;
  const FailureState({required this.errorMessage});

  factory FailureState.fromJson(Map<String, dynamic> json) =>
      _$FailureStateFromJson(json);

  Map<String, dynamic> toJson() {
    return {"runtimeType": "FailureState", "errorMessage": errorMessage};
  }
}
