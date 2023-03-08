// ignore_for_file: prefer_const_constructors
import 'package:invoice_api_client/invoice_api_client.dart' as invoice_api;
import 'package:bl_objects_repository/item/index.dart';
import 'package:invoice_api_client/items/models/itemDTOReceive.dart';
import 'package:invoice_api_client/items/models/itemDTOSend.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockItemApiClient extends Mock implements invoice_api.ItemApiClient {}

class MockItem extends Mock implements invoice_api.ItemDTOReceive {}

void main() {
  group('ItemRepository', () {
    late invoice_api.ItemApiClient itemApiClient;
    late ItemRepository itemRepository;

    setUp(() {
      itemApiClient = MockItemApiClient();
      itemRepository = ItemRepository(
        itemApiClient: itemApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal MetaWeatherApiClient when not injected', () {
        expect(ItemRepository(), isNotNull);
      });
    });

    group('deleteItem', () {
      const id = 'mock-query';
      test('deleteItem calls right method with right id', () async {
        try {
          await itemRepository.deleteItem(id);
        } catch (_) {}
        verify(() => itemApiClient.deleteItem(id)).called(1);
      });
    });

    group('getItem', () {
      const id = 'mock-query';
      test('getItem calls right method with right id', () async {
        try {
          await itemRepository.getItem(id);
        } catch (_) {}
        verify(() => itemApiClient.getItemById(id)).called(1);
      });

      test('returns correct Item on success', () async {
        final item = ItemDTOReceive(
            userId: '62e393a5fb12b967fea3d9d0',
            id: '62e393a5fb12b967fea3d9d0',
            title: 'abcefghijklmnopqrstuvwxyztest',
            taxIncluded: true,
            modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            tax: 0.19,
            discount: 0.02,
            pricePerUnit: 17.625,
            taxedAmount: 15,
            description: "Bricks for construction");
        when(() => itemApiClient.getItemById(any())).thenAnswer(
          (_) async => item,
        );
        final actual = await itemRepository.getItem(id);
        expect(
          actual,
          ItemDTOReceive(
              userId: '62e393a5fb12b967fea3d9d0',
              id: '62e393a5fb12b967fea3d9d0',
              title: 'abcefghijklmnopqrstuvwxyztest',
              taxIncluded: true,
              modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
              creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
              tax: 0.19,
              discount: 0.02,
              pricePerUnit: 17.625,
              taxedAmount: 15,
              description: "Bricks for construction"),
        );
      });
    });
    group('getItems', () {
      const id = 'mock-query';
      test('getItems calls right method with right id', () async {
        try {
          await itemRepository.getItems({});
        } catch (_) {}
        verify(() => itemApiClient.getItems({})).called(1);
      });

      test('returns correct Object on success', () async {
        final item = ItemDTOReceive(
            userId: '62e393a5fb12b967fea3d9d0',
            id: '62e393a5fb12b967fea3d9d0',
            title: 'abcefghijklmnopqrstuvwxyztest',
            taxIncluded: true,
            modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
            tax: 0.19,
            discount: 0.02,
            pricePerUnit: 17.625,
            taxedAmount: 15,
            description: "Bricks for construction");
        when(() => itemApiClient.getItems({})).thenAnswer(
          (_) async => {
            "itemList": [item],
            "lastN": 1
          },
        );
        final actual = await itemRepository.getItems({});
        expect(
            actual,
            ItemResponse(itemList: [
              ItemDTOReceive(
                  userId: '62e393a5fb12b967fea3d9d0',
                  id: '62e393a5fb12b967fea3d9d0',
                  title: 'abcefghijklmnopqrstuvwxyztest',
                  taxIncluded: true,
                  modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                  creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
                  tax: 0.19,
                  discount: 0.02,
                  pricePerUnit: 17.625,
                  taxedAmount: 15,
                  description: "Bricks for construction")
            ], lastN: 1));
      });
    });
    group('updateItem', () {
      final item = ItemDTOReceive(
          userId: '62e393a5fb12b967fea3d9d0',
          id: '62e393a5fb12b967fea3d9d0',
          title: 'abcefghijklmnopqrstuvwxyztest',
          taxIncluded: true,
          modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          tax: 0.19,
          discount: 0.02,
          pricePerUnit: 17.625,
          taxedAmount: 15,
          description: "Bricks for construction");
      test('calls update with correct item', () async {
        try {
          await itemRepository.updateItem(item);
        } catch (_) {}
        verify(() => itemApiClient.updateItem(item)).called(1);
      });
    });
    group('insert', () {
      final item = ItemDTOSend(
          userId: '62e393a5fb12b967fea3d9d0',
          title: 'abcefghijklmnopqrstuvwxyztest',
          taxIncluded: true,
          tax: 0.19,
          discount: 0.02,
          pricePerUnit: 17.625,
          taxedAmount: 15,
          description: "Bricks for construction");
      test('calls insert with correct item', () async {
        try {
          await itemRepository.insertItem(
              userId: item.userId,
              title: item.title,
              taxIncluded: item.taxIncluded,
              tax: item.tax,
              discount: item.discount,
              pricePerUnit: item.pricePerUnit,
              taxedAmount: item.taxedAmount!,
              description: item.description);
        } catch (_) {}
        verify(() => itemApiClient.insertItem(item)).called(1);
      });
    });
  });
}
