// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:easyinvoice/bl_objects/invoice/invoice_cubit.dart';
import 'package:invoice_api_client/complementary_models/address.dart';
import 'package:invoice_api_client/complementary_models/legal_form.dart';
import 'package:invoice_api_client/invoice_api_client.dart';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bl_objects_repository/invoice/index.dart' as invoice_repository;

import '../../helpers/hydrated_bloc.dart';

class MockInvoiceRepository extends Mock
    implements invoice_repository.InvoiceRepository {}

class MockInvoice extends Mock implements InvoiceDTO {}

void main() {
  initHydratedStorage();

  group('invoiceCubit', () {
    late InvoiceDTO invoice;
    late invoice_repository.InvoiceRepository invoiceRepository;
    late InvoiceCubit invoiceCubit;
    late InvoiceDTO rinvoice;
    late InvoiceDTO rinvoice2;
    setUp(() async {
      rinvoice = InvoiceDTO(
        userId: '62e393a5fb12b967fea3d9d0',
        id: '62e393a5fb12b967fea3d9d0',
        modifiedDates: [DateTime.parse("2022-08-11T09:12:11.524Z")],
        creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
        paymentInformation:
            PaymentInformation(type: "type", details: "details"),
        paymentAfterTaxAndDiscount: 34,
        clientId: '62e393a5fb12b967fea3d9d0',
        invoiceNumber: '24235236432',
        isPaid: false,
        deliveryDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
        discount: 0.1,
        itemList: [],
        paymentDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
        addressIssuer: Address(
            streetName: "streetName",
            streetNumber: "streetNumber",
            zipCode: "zipCode",
            city: "city",
            state: "state",
            country: "country",
            creationDate: DateTime.now(),
            modifiedDates: []),
        addressReceiver: Address(
            streetName: "streetName",
            streetNumber: "streetNumber",
            zipCode: "zipCode",
            city: "city",
            state: "state",
            country: "country",
            creationDate: DateTime.now(),
            modifiedDates: []),
        isDraft: false,
        isOverdue: false,
        legalForm: LegalForm.GbR,
        registryCourt: 'registryCourt',
        taxId: 'taxNumber',
        ustId: 'vatNumber',
        taxExemptionReason: "none",
        registryNumber: "HRB 123456",
        reminderDates: [],
        issuedDate: null,
        nameIssuer: "Rudolf",
        nameReceiver: "Pfeiler",
        overdueDate: DateTime.now().add(Duration(days: 30)),
      );
      rinvoice2 = InvoiceDTO(
        userId: '62e393a5fb12b967fea3d9d0',
        id: '62e393a5fb12b967fea3d9d0',
        modifiedDates: [DateTime.parse("2022-08-11T09:12:11.524Z")],
        creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
        paymentInformation:
            PaymentInformation(type: "type", details: "details"),
        paymentAfterTaxAndDiscount: 34,
        clientId: '62e393a5fb12b967fea3d9d0',
        invoiceNumber: '24235236432',
        isPaid: false,
        deliveryDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
        discount: 0.1,
        itemList: [],
        paymentDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
        addressIssuer: Address(
            streetName: "streetName",
            streetNumber: "streetNumber",
            zipCode: "zipCode",
            city: "city",
            state: "state",
            country: "country",
            creationDate: DateTime.now(),
            modifiedDates: []),
        addressReceiver: Address(
            streetName: "streetName",
            streetNumber: "streetNumber",
            zipCode: "zipCode",
            city: "city",
            state: "state",
            country: "country",
            creationDate: DateTime.now(),
            modifiedDates: []),
        isDraft: false,
        isOverdue: false,
        legalForm: LegalForm.GbR,
        registryCourt: 'registryCourt',
        taxId: 'taxNumber',
        ustId: 'vatNumber',
        taxExemptionReason: "none",
        registryNumber: "HRB 123456",
        reminderDates: [],
        issuedDate: null,
        nameIssuer: "Rudolf",
        nameReceiver: "Pfeiler",
        overdueDate: DateTime.now().add(Duration(days: 30)),
      );
      invoice = MockInvoice();
      invoiceRepository = MockInvoiceRepository();
      when(() => invoice.paymentInformation)
          .thenReturn(PaymentInformation(type: "type", details: "details"));
      when(() => invoice.paymentAfterTaxAndDiscount).thenReturn(34);
      when(() => invoice.clientId).thenReturn('62e393a5fb12b967fea3d9d0');
      when(() => invoice.creationDate).thenReturn(DateTime.now());
      when(() => invoice.modifiedDates).thenReturn([DateTime.now()]);
      when(() => invoice.invoiceNumber).thenReturn("242352364323");
      when(() => invoice.id).thenReturn("9f239d98v9889090a0f38c");
      when(() => invoice.userId).thenReturn("9f239d98v9889090a0f38c");
      when(() => invoice.isPaid).thenReturn(false);
      when(() => invoice.deliveryDate).thenReturn(DateTime.now());
      when(() => invoice.itemList).thenReturn([]);
      when(() => invoice.paymentDate).thenReturn(DateTime.now());
      when(() => invoice.discount).thenReturn(0.1);
      when(() => invoice.addressIssuer).thenReturn(Address(
          streetName: "streetName",
          streetNumber: "streetNumber",
          zipCode: "zipCode",
          city: "city",
          state: "state",
          country: "country",
          creationDate: DateTime.now(),
          modifiedDates: []));
      when(() => invoice.addressReceiver).thenReturn(Address(
          streetName: "streetName",
          streetNumber: "streetNumber",
          zipCode: "zipCode",
          city: "city",
          state: "state",
          country: "country",
          creationDate: DateTime.now(),
          modifiedDates: []));
      when(() => invoice.isDraft).thenReturn(false);
      when(() => invoice.nameIssuer).thenReturn("Rudi");

      when(
        () => invoiceRepository.getInvoice(any()),
      ).thenAnswer((_) async => rinvoice);
      invoiceCubit = InvoiceCubit(invoiceRepository);
    });

    test('initial state is correct', () {
      final weatherCubit = InvoiceCubit(invoiceRepository);
      expect(weatherCubit.state, InitialState());
    });

    group('toJson/fromJson', () {
      test('work properly', () async {
        final invoiceCubit = InvoiceCubit(invoiceRepository);
        await invoiceCubit.fetchInvoice("id");
        when(() => invoiceRepository.getInvoice("id"))
            .thenAnswer((_) async => Future.value(rinvoice));
        expect(
          invoiceCubit.fromJson(invoiceCubit.toJson(invoiceCubit.state)!),
          invoiceCubit.state,
        );
      });
    });

    group('right states', () {
      test('is in InvoiceFetched after invoice is returned', () async {
        final invoiceCubit = InvoiceCubit(invoiceRepository);
        when(() => invoiceRepository.getInvoice("id"))
            .thenAnswer((_) async => Future.value(rinvoice));
        await invoiceCubit.fetchInvoice("id");
        expect(
          InvoiceFetchedState(invoice: rinvoice),
          invoiceCubit.state,
        );
      });
      test('is in FailureState after exception is thrown', () async {
        final invoiceCubit = InvoiceCubit(invoiceRepository);
        when(() => invoiceRepository.getInvoice("id"))
            .thenAnswer((_) async => throw Exception("crash"));
        await invoiceCubit.fetchInvoice("id");
        expect(
          FailureState(errorMessage: "crash"),
          invoiceCubit.state,
        );
      });
    });
    group('pagination', () {
      test('pagination works', () async {
        final invoiceCubit = InvoiceCubit(invoiceRepository);
        when(() => invoiceRepository.getInvoices(any())).thenAnswer((_) async =>
            Future.value(invoice_repository.InvoiceResponse(
                invoiceList: [rinvoice], lastN: 1)));
        await invoiceCubit.fetchInvoices(query: {}, pagination: true);
        when(() => invoiceRepository.getInvoices(any())).thenAnswer((_) async =>
            Future.value(invoice_repository.InvoiceResponse(
                invoiceList: [rinvoice2], lastN: 2)));
        await invoiceCubit.fetchInvoices(query: {}, pagination: true);
        expect(
          InvoiceListFetchedState(invoiceList: [rinvoice, rinvoice2], lastN: 2),
          invoiceCubit.state,
        );
      });
      test('pagination set on false works', () async {
        final invoiceCubit = InvoiceCubit(invoiceRepository);
        when(() => invoiceRepository.getInvoices(any())).thenAnswer((_) async =>
            Future.value(invoice_repository.InvoiceResponse(
                invoiceList: [rinvoice], lastN: 1)));
        await invoiceCubit.fetchInvoices(query: {}, pagination: true);
        when(() => invoiceRepository.getInvoices(any())).thenAnswer((_) async =>
            Future.value(invoice_repository.InvoiceResponse(
                invoiceList: [rinvoice2], lastN: 2)));
        await invoiceCubit.fetchInvoices(query: {}, pagination: true);
        expect(
          InvoiceListFetchedState(invoiceList: [rinvoice, rinvoice2], lastN: 2),
          invoiceCubit.state,
        );
        await invoiceCubit.fetchInvoices(query: {}, pagination: false);
        expect(
          InvoiceListFetchedState(invoiceList: [rinvoice2], lastN: 1),
          invoiceCubit.state,
        );
      });
    });
  });
}
