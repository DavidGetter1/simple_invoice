// ignore_for_file: prefer_const_constructors
import 'package:invoice_api_client/complementary_models/address.dart';
import 'package:invoice_api_client/complementary_models/legal_form.dart';
import 'package:invoice_api_client/invoice_api_client.dart' as invoice_api;
import 'package:bl_objects_repository/invoice/index.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:invoice_api_client/invoices/models/invoiceDTO.dart';
import 'package:invoice_api_client/items/models/detailedItem.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockInvoiceApiClient extends Mock
    implements invoice_api.InvoiceApiClient {}

class MockInvoice extends Mock implements invoice_api.InvoiceDTO {}

void main() {
  DateTime now = DateTime.now();

  group('InvoiceRepository', () {
    late invoice_api.InvoiceApiClient invoiceApiClient;
    late InvoiceRepository invoiceRepository;

    setUp(() {
      invoiceApiClient = MockInvoiceApiClient();
      invoiceRepository = InvoiceRepository(
        invoiceApiClient: invoiceApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal MetaWeatherApiClient when not injected', () {
        expect(InvoiceRepository(), isNotNull);
      });
    });

    group('deleteInvoice', () {
      const id = 'mock-query';
      test('deleteInvoice calls right method with right id', () async {
        try {
          await invoiceRepository.deleteInvoice(id);
        } catch (_) {}
        verify(() => invoiceApiClient.deleteInvoice(id)).called(1);
      });
    });

    group('getInvoice', () {
      const id = 'mock-query';
      test('getInvoice calls right method with right id', () async {
        try {
          await invoiceRepository.getInvoice(id);
        } catch (_) {}
        verify(() => invoiceApiClient.getInvoiceById(id)).called(1);
      });

      test('returns correct Invoice on success', () async {
        final invoice = InvoiceDTO(
          id: '123',
          userId: 'user_1',
          clientId: 'client_1',
          nameReceiver: 'Receiver',
          addressReceiver: Address(
              streetName: "streetName",
              streetNumber: "streetNumber",
              zipCode: "zipCode",
              city: "city",
              state: "state",
              country: "country",
              creationDate: now,
              modifiedDates: []),
          nameIssuer: 'Issuer',
          addressIssuer: Address(
              streetName: "streetName",
              streetNumber: "streetNumber",
              zipCode: "zipCode",
              city: "city",
              state: "state",
              country: "country",
              creationDate: now,
              modifiedDates: []),
          issuedDate: now,
          ustId: 'ust_123',
          taxId: 'tax_123',
          invoiceNumber: 'inv_123',
          paymentInformation: PaymentInformation(details: '', type: ''),
          itemList: [
            DetailedItem(quantity: 2, quantityIdentifier: 'pc', id: 'item_1'),
            DetailedItem(quantity: 1, quantityIdentifier: 'kg', id: 'item_2'),
          ],
          paymentAfterTaxAndDiscount: 20.0,
          discount: 5.0,
          taxExemptionReason: 'N/A',
          legalForm: LegalForm.GbR,
          registryCourt: 'court_123',
          registryNumber: 'reg_123',
          isPaid: true,
          isDraft: false,
          isOverdue: false,
          reminderDates: [
            now.add(Duration(days: 7)),
            now.add(Duration(days: 14)),
          ],
          overdueDate: now.add(Duration(days: 30)),
          creationDate: now,
          paymentDate: now.add(Duration(days: 15)),
          deliveryDate: now.add(Duration(days: 7)),
          modifiedDates: [
            now.add(Duration(days: -1)),
            now.add(Duration(days: -2)),
          ],
        );
        when(() => invoiceApiClient.getInvoiceById(any())).thenAnswer(
          (_) async => invoice,
        );
        final actual = await invoiceRepository.getInvoice(id);
        expect(
            actual,
            InvoiceDTO(
              id: '123',
              userId: 'user_1',
              clientId: 'client_1',
              nameReceiver: 'Receiver',
              addressReceiver: Address(
                  streetName: "streetName",
                  streetNumber: "streetNumber",
                  zipCode: "zipCode",
                  city: "city",
                  state: "state",
                  country: "country",
                  creationDate: now,
                  modifiedDates: []),
              nameIssuer: 'Issuer',
              addressIssuer: Address(
                  streetName: "streetName",
                  streetNumber: "streetNumber",
                  zipCode: "zipCode",
                  city: "city",
                  state: "state",
                  country: "country",
                  creationDate: now,
                  modifiedDates: []),
              issuedDate: now,
              ustId: 'ust_123',
              taxId: 'tax_123',
              invoiceNumber: 'inv_123',
              paymentInformation: PaymentInformation(details: '', type: ''),
              itemList: [
                DetailedItem(
                    quantity: 2, quantityIdentifier: 'pc', id: 'item_1'),
                DetailedItem(
                    quantity: 1, quantityIdentifier: 'kg', id: 'item_2'),
              ],
              paymentAfterTaxAndDiscount: 20.0,
              discount: 5.0,
              taxExemptionReason: 'N/A',
              legalForm: LegalForm.GbR,
              registryCourt: 'court_123',
              registryNumber: 'reg_123',
              isPaid: true,
              isDraft: false,
              isOverdue: false,
              reminderDates: [
                now.add(Duration(days: 7)),
                now.add(Duration(days: 14)),
              ],
              overdueDate: now.add(Duration(days: 30)),
              creationDate: now,
              paymentDate: now.add(Duration(days: 15)),
              deliveryDate: now.add(Duration(days: 7)),
              modifiedDates: [
                now.add(Duration(days: -1)),
                now.add(Duration(days: -2)),
              ],
            ));
      });
    });
    group('getInvoices', () {
      const id = 'mock-query';
      test('getInvoices calls right method with right id', () async {
        try {
          await invoiceRepository.getInvoices({});
        } catch (_) {}
        verify(() => invoiceApiClient.getInvoices({})).called(1);
      });

      test('returns correct Object on success', () async {
        final invoice = InvoiceDTO(
          id: '123',
          userId: 'user_1',
          clientId: 'client_1',
          nameReceiver: 'Receiver',
          addressReceiver: Address(
              streetName: "streetName",
              streetNumber: "streetNumber",
              zipCode: "zipCode",
              city: "city",
              state: "state",
              country: "country",
              creationDate: now,
              modifiedDates: []),
          nameIssuer: 'Issuer',
          addressIssuer: Address(
              streetName: "streetName",
              streetNumber: "streetNumber",
              zipCode: "zipCode",
              city: "city",
              state: "state",
              country: "country",
              creationDate: now,
              modifiedDates: []),
          issuedDate: now,
          ustId: 'ust_123',
          taxId: 'tax_123',
          invoiceNumber: 'inv_123',
          paymentInformation: PaymentInformation(details: '', type: ''),
          itemList: [
            DetailedItem(quantity: 2, quantityIdentifier: 'pc', id: 'item_1'),
            DetailedItem(quantity: 1, quantityIdentifier: 'kg', id: 'item_2'),
          ],
          paymentAfterTaxAndDiscount: 20.0,
          discount: 5.0,
          taxExemptionReason: 'N/A',
          legalForm: LegalForm.GbR,
          registryCourt: 'court_123',
          registryNumber: 'reg_123',
          isPaid: true,
          isDraft: false,
          isOverdue: false,
          reminderDates: [
            now.add(Duration(days: 7)),
            now.add(Duration(days: 14)),
          ],
          overdueDate: now.add(Duration(days: 30)),
          creationDate: now,
          paymentDate: now.add(Duration(days: 15)),
          deliveryDate: now.add(Duration(days: 7)),
          modifiedDates: [
            now.add(Duration(days: -1)),
            now.add(Duration(days: -2)),
          ],
        );
        when(() => invoiceApiClient.getInvoices({})).thenAnswer(
          (_) async => {
            "invoiceList": [invoice],
            "lastN": 1
          },
        );
        final actual = await invoiceRepository.getInvoices({});
        expect(
            actual,
            InvoiceResponse(invoiceList: [
              InvoiceDTO(
                id: '123',
                userId: 'user_1',
                clientId: 'client_1',
                nameReceiver: 'Receiver',
                addressReceiver: Address(
                    streetName: "streetName",
                    streetNumber: "streetNumber",
                    zipCode: "zipCode",
                    city: "city",
                    state: "state",
                    country: "country",
                    creationDate: now,
                    modifiedDates: []),
                nameIssuer: 'Issuer',
                addressIssuer: Address(
                    streetName: "streetName",
                    streetNumber: "streetNumber",
                    zipCode: "zipCode",
                    city: "city",
                    state: "state",
                    country: "country",
                    creationDate: now,
                    modifiedDates: []),
                issuedDate: now,
                ustId: 'ust_123',
                taxId: 'tax_123',
                invoiceNumber: 'inv_123',
                paymentInformation: PaymentInformation(details: '', type: ''),
                itemList: [
                  DetailedItem(
                      quantity: 2, quantityIdentifier: 'pc', id: 'item_1'),
                  DetailedItem(
                      quantity: 1, quantityIdentifier: 'kg', id: 'item_2'),
                ],
                paymentAfterTaxAndDiscount: 20.0,
                discount: 5.0,
                taxExemptionReason: 'N/A',
                legalForm: LegalForm.GbR,
                registryCourt: 'court_123',
                registryNumber: 'reg_123',
                isPaid: true,
                isDraft: false,
                isOverdue: false,
                reminderDates: [
                  now.add(Duration(days: 7)),
                  now.add(Duration(days: 14)),
                ],
                overdueDate: now.add(Duration(days: 30)),
                creationDate: now,
                paymentDate: now.add(Duration(days: 15)),
                deliveryDate: now.add(Duration(days: 7)),
                modifiedDates: [
                  now.add(Duration(days: -1)),
                  now.add(Duration(days: -2)),
                ],
              )
            ], lastN: 1));
      });
    });
    group('updateInvoice', () {
      final invoice = InvoiceDTO(
        id: '123',
        userId: 'user_1',
        clientId: 'client_1',
        nameReceiver: 'Receiver',
        addressReceiver: Address(
            streetName: "streetName",
            streetNumber: "streetNumber",
            zipCode: "zipCode",
            city: "city",
            state: "state",
            country: "country",
            creationDate: now,
            modifiedDates: []),
        nameIssuer: 'Issuer',
        addressIssuer: Address(
            streetName: "streetName",
            streetNumber: "streetNumber",
            zipCode: "zipCode",
            city: "city",
            state: "state",
            country: "country",
            creationDate: now,
            modifiedDates: []),
        issuedDate: now,
        ustId: 'ust_123',
        taxId: 'tax_123',
        invoiceNumber: 'inv_123',
        paymentInformation: PaymentInformation(details: '', type: ''),
        itemList: [
          DetailedItem(quantity: 2, quantityIdentifier: 'pc', id: 'item_1'),
          DetailedItem(quantity: 1, quantityIdentifier: 'kg', id: 'item_2'),
        ],
        paymentAfterTaxAndDiscount: 20.0,
        discount: 5.0,
        taxExemptionReason: 'N/A',
        legalForm: LegalForm.GbR,
        registryCourt: 'court_123',
        registryNumber: 'reg_123',
        isPaid: true,
        isDraft: false,
        isOverdue: false,
        reminderDates: [
          now.add(Duration(days: 7)),
          now.add(Duration(days: 14)),
        ],
        overdueDate: now.add(Duration(days: 30)),
        creationDate: now,
        paymentDate: now.add(Duration(days: 15)),
        deliveryDate: now.add(Duration(days: 7)),
        modifiedDates: [
          now.add(Duration(days: -1)),
          now.add(Duration(days: -2)),
        ],
      );
      test('calls update with correct invoice', () async {
        try {
          await invoiceRepository.updateInvoice(invoice);
        } catch (_) {}
        verify(() => invoiceApiClient.updateInvoice(invoice)).called(1);
      });
    });
    group('insert', () {
      final invoice = InvoiceDTO(
        id: '123',
        userId: 'user_1',
        clientId: 'client_1',
        nameReceiver: 'Receiver',
        addressReceiver: Address(
            streetName: "streetName",
            streetNumber: "streetNumber",
            zipCode: "zipCode",
            city: "city",
            state: "state",
            country: "country",
            creationDate: now,
            modifiedDates: []),
        nameIssuer: 'Issuer',
        addressIssuer: Address(
            streetName: "streetName",
            streetNumber: "streetNumber",
            zipCode: "zipCode",
            city: "city",
            state: "state",
            country: "country",
            creationDate: now,
            modifiedDates: []),
        issuedDate: now,
        ustId: 'ust_123',
        taxId: 'tax_123',
        invoiceNumber: 'inv_123',
        paymentInformation: PaymentInformation(details: '', type: ''),
        itemList: [
          DetailedItem(quantity: 2, quantityIdentifier: 'pc', id: 'item_1'),
          DetailedItem(quantity: 1, quantityIdentifier: 'kg', id: 'item_2'),
        ],
        paymentAfterTaxAndDiscount: 20.0,
        discount: 5.0,
        taxExemptionReason: 'N/A',
        legalForm: LegalForm.GbR,
        registryCourt: 'court_123',
        registryNumber: 'reg_123',
        isPaid: true,
        isDraft: false,
        isOverdue: false,
        reminderDates: [
          now.add(Duration(days: 7)),
          now.add(Duration(days: 14)),
        ],
        overdueDate: now.add(Duration(days: 30)),
        creationDate: now,
        paymentDate: now.add(Duration(days: 15)),
        deliveryDate: now.add(Duration(days: 7)),
        modifiedDates: [
          now.add(Duration(days: -1)),
          now.add(Duration(days: -2)),
        ],
      );
      test('calls insert with correct invoice', () async {
        try {
          await invoiceRepository.insertInvoice(invoice);
        } catch (_) {}
        verify(() => invoiceApiClient.insertInvoice(invoice)).called(1);
      });
    });
  });
}
