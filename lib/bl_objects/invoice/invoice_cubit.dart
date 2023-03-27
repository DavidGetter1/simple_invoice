import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:bl_objects_repository/invoice/index.dart'
    show InvoiceRepository, InvoiceResponse;
part 'invoice_cubit.g.dart';
part 'invoice_state.dart';

class InvoiceCubit extends HydratedCubit<InvoiceState> {
  InvoiceCubit(this._invoiceRepository) : super(InitialState()) {
    print("InvoiceCubit constructor");
  }

  final InvoiceRepository _invoiceRepository;
  List<InvoiceDTO> _invoiceList = [];
  int _skip = 0;

  Future<void> updateInvoice(InvoiceDTO invoice) async {
    emit(LoadingState());

    try {
      await _invoiceRepository.updateInvoice(invoice);

      emit(InvoiceUpdatedState());
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> fetchInvoice(String? id) async {
    if (id == null || id.isEmpty) return;

    emit(LoadingState());

    try {
      final invoice = await _invoiceRepository.getInvoice(id);

      emit(InvoiceFetchedState(invoice: invoice));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> deleteInvoice(String? id) async {
    if (id == null || id.isEmpty) return;

    emit(LoadingState());

    try {
      await _invoiceRepository.deleteInvoice(id);
      emit(InvoiceDeletedState());
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> fetchInvoices(
      {Map<String, String>? query = const {}, bool pagination = false}) async {
    if (query == null) return;
    query['skip'] = '$_skip';
    emit(LoadingState());
    if (!pagination) {
      _skip = 0;
      _invoiceList = [];
    }

    try {
      InvoiceResponse response = await _invoiceRepository.getInvoices(query);
      if (pagination) {
        _skip = response.lastN;
      }
      if (response.invoiceList.isEmpty) {
        emit(NoMoreResultsState());
        return;
      }
      _invoiceList += response.invoiceList;
      emit(InvoiceListFetchedState(
          invoiceList: _invoiceList, lastN: response.lastN));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  Future<void> insertInvoice(InvoiceDTO invoice) async {
    emit(LoadingState());

    try {
      final String id = await _invoiceRepository.insertInvoice(invoice);

      emit(InvoiceCreatedState(id: id));
    } on Exception {
      emit(const FailureState(errorMessage: 'errorMessage'));
    }
  }

  //better ideas are appreciated
  @override
  InvoiceState? fromJson(Map<String, dynamic> json) {
    switch (json["state"]) {
      case "InitialState":
        return InitialState();
      case "LoadingState":
        return LoadingState();
      case "InvoiceDeletedState":
        return InvoiceDeletedState();
      case "InvoiceUpdatedState":
        return InvoiceUpdatedState();
      case "InvoiceFetchedState":
        return InvoiceFetchedState.fromJson(json["class"]);
      case "InvoiceCreatedState":
        return InvoiceCreatedState.fromJson(json["class"]);
      case "InvoiceListFetchedState":
        return InvoiceListFetchedState.fromJson(json["class"]);
      case "FailureState":
        return FailureState.fromJson(json["class"]);
    }
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(InvoiceState state) {
    switch (state.runtimeType) {
      case InvoiceCreatedState:
        return {
          "state": "InvoiceCreatedState",
          "class": (state as InvoiceCreatedState).toJson()
        };
      case InvoiceFetchedState:
        return {
          "state": "InvoiceFetchedState",
          "class": (state as InvoiceFetchedState).toJson()
        };
      case InvoiceListFetchedState:
        return {
          "state": "InvoiceListFetchedState",
          "class": (state as InvoiceListFetchedState).toJson()
        };
      case InitialState:
        return {"state": "InitialState"};
      case LoadingState:
        return {"state": "LoadingState"};
      case InvoiceDeletedState:
        return {"state": "InvoiceDeletedState"};
      case InvoiceUpdatedState:
        return {"state": "InvoiceUpdatedState"};
      case FailureState:
        return {
          "state": "FailureState",
          "class": (state as FailureState).toJson()
        };

      default:
        return {};
    }
  }
}
