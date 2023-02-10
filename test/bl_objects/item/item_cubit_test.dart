// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:easyinvoice/bl_objects/item/item_cubit.dart';
import 'package:invoice_api/invoice_api_client.dart';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bl_objects_repository/item/index.dart'
as item_repository;

import '../../helpers/hydrated_bloc.dart';



class MockItemRepository extends Mock
    implements item_repository.ItemRepository {}

class MockItem extends Mock implements Item {}

void main() {
  initHydratedStorage();

  group('itemCubit', () {
    late Item item;
    late item_repository.ItemRepository itemRepository;
    late ItemCubit itemCubit;
    late Item ritem;
    late Item ritem2;
    setUp(() async {
      ritem = Item(
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
          description: "Bricks for construction"
      );
      ritem2 = Item(
          userId: '62e393a5fb12b967fea3d9d0',
          id: '62e393a5fb12b967fea3d9d0',
          title: 'abcefghijklmnopqrstuvwxyztest',
          taxIncluded: true,
          modifiedDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          creationDate: DateTime.parse("2022-08-11T09:12:11.524Z"),
          tax: 0.18,
          discount: 0.02,
          pricePerUnit: 17.625,
          taxedAmount: 15,
          description: "Bricks for construction"
      );
      item = MockItem();
      itemRepository = MockItemRepository();
      when(() => item.taxedAmount).thenReturn(15);
      when(() => item.tax).thenReturn(0.5);
      when(() => item.discount).thenReturn(0.5);
      when(() => item.creationDate).thenReturn(DateTime.now());
      when(() => item.modifiedDate).thenReturn(DateTime.now());
      when(() => item.description).thenReturn("description");
      when(() => item.id).thenReturn("9f239d98v9889090a0f38c");
      when(() => item.userId).thenReturn("9f239d98v9889090a0f38c");
      when(() => item.taxIncluded).thenReturn(false);
      when(() => item.pricePerUnit).thenReturn(15);
      when(() => item.title).thenReturn("title");
      when(
            () => itemRepository.getItem(any()),
      ).thenAnswer((_) async => ritem);
      itemCubit = ItemCubit(itemRepository);
    });

    test('initial state is correct', () {
      final weatherCubit = ItemCubit(itemRepository);
      expect(weatherCubit.state, InitialState());
    });

    group('toJson/fromJson', () {
      test('work properly', () async {
        final itemCubit = ItemCubit(itemRepository);
        await itemCubit.fetchItem("id");
        when(() => itemRepository.getItem("id")).thenAnswer((_) async => Future.value(ritem));
        expect(
          itemCubit.fromJson(itemCubit.toJson(itemCubit.state)!),
          itemCubit.state,
        );
      });
    });

    group('right states', () {
      test('is in ItemFetched after item is returned', () async {
        final itemCubit = ItemCubit(itemRepository);
        when(() => itemRepository.getItem("id")).thenAnswer((_) async => Future.value(ritem));
        await itemCubit.fetchItem("id");
        expect(
          ItemFetchedState(item: ritem),
          itemCubit.state,
        );
      });
      test('is in FailureState after exception is thrown', () async {
        final itemCubit = ItemCubit(itemRepository);
        when(() => itemRepository.getItem("id")).thenAnswer((_) async => throw Exception("crash"));
        await itemCubit.fetchItem("id");
        expect(
          FailureState(errorMessage: "crash"),
          itemCubit.state,
        );
      });
    });
    group('pagination', () {
      test('pagination works', () async {
        final itemCubit = ItemCubit(itemRepository);
        when(() => itemRepository.getItems(any())).thenAnswer((_) async => Future.value(item_repository.ItemResponse(itemList: [ritem], lastN: 1)));
        await itemCubit.fetchItems(query: {}, pagination: true);
        when(() => itemRepository.getItems(any())).thenAnswer((_) async => Future.value(item_repository.ItemResponse(itemList: [ritem2], lastN: 2)));
        await itemCubit.fetchItems(query: {}, pagination: true);
        expect(
          ItemListFetchedState(itemList: [ritem, ritem2], lastN: 2),
          itemCubit.state,
        );
      });
      test('pagination set on false works', () async {
        final itemCubit = ItemCubit(itemRepository);
        when(() => itemRepository.getItems(any())).thenAnswer((_) async => Future.value(item_repository.ItemResponse(itemList: [ritem], lastN: 1)));
        await itemCubit.fetchItems(query: {}, pagination: true);
        when(() => itemRepository.getItems(any())).thenAnswer((_) async => Future.value(item_repository.ItemResponse(itemList: [ritem2], lastN: 2)));
        await itemCubit.fetchItems(query: {}, pagination: true);
        expect(
          ItemListFetchedState(itemList: [ritem, ritem2], lastN: 2),
          itemCubit.state,
        );
        await itemCubit.fetchItems(query: {}, pagination: false);
        expect(
          ItemListFetchedState(itemList: [ritem2], lastN: 1),
          itemCubit.state,
        );
      });
    });
  });
}
