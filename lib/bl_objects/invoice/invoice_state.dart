part of 'invoice_cubit.dart';

abstract class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object?> get props => [];
}

class InitialState extends InvoiceState {}

class LoadingState extends InvoiceState {}

class InvoiceDeletedState extends InvoiceState {}

class InvoiceUpdatedState extends InvoiceState {}

class NoMoreResultsState extends InvoiceState {}

@JsonSerializable()
class InvoiceCreatedState extends InvoiceState {
  final String id;
  const InvoiceCreatedState({required this.id});

  factory InvoiceCreatedState.fromJson(Map<String, dynamic> json) =>
      _$InvoiceCreatedStateFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceCreatedStateToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InvoiceFetchedState extends InvoiceState {
  final InvoiceDTO invoice;
  const InvoiceFetchedState({required this.invoice});

  factory InvoiceFetchedState.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFetchedStateFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceFetchedStateToJson(this);

  @override
  List<Object?> get props => [invoice];
}

@JsonSerializable(explicitToJson: true)
class InvoiceListFetchedState extends InvoiceState {
  final int lastN;
  final List<InvoiceDTO> invoiceList;
  const InvoiceListFetchedState(
      {required this.invoiceList, required this.lastN});

  factory InvoiceListFetchedState.fromJson(Map<String, dynamic> json) =>
      _$InvoiceListFetchedStateFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceListFetchedStateToJson(this);

  @override
  List<Object?> get props => [invoiceList];
}

@JsonSerializable()
class FailureState extends InvoiceState {
  final String errorMessage;
  const FailureState({required this.errorMessage});

  factory FailureState.fromJson(Map<String, dynamic> json) =>
      _$FailureStateFromJson(json);

  Map<String, dynamic> toJson() => _$FailureStateToJson(this);
}
