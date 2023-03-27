// ignore_for_file: prefer_const_constructors
import 'package:bl_objects_repository/item/models/item.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:easyinvoice/bl_objects/item/crud/item_cubit.dart';
import 'package:invoice_api_client/invoice_api_client.dart';
import 'package:invoice_api_client/items/models/itemResponse.dart';
import 'package:invoice_api_client/items/models/itemResponse.dart';

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:bl_objects_repository/item/index.dart' as item_repository;

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
          tax: 0.19,
          discount: 0.02,
          pricePerUnit: 17.625,
          description: "Bricks for construction");
      ritem2 = Item(
          userId: '62e393a5fb12b967fea3d9d0',
          id: '62e393a5fb12b967fea3d9d0',
          title: 'abcefghijklmnopqrstuvwxyztest',
          tax: 0.18,
          discount: 0.02,
          pricePerUnit: 17.625,
          description: "Bricks for construction");
      item = MockItem();
      itemRepository = MockItemRepository();
      when(() => item.tax).thenReturn(0.5);
      when(() => item.discount).thenReturn(0.5);
      when(() => item.description).thenReturn("description");
      when(() => item.id).thenReturn("9f239d98v9889090a0f38c");
      when(() => item.userId).thenReturn("9f239d98v9889090a0f38c");
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
        when(() => itemRepository.getItem("id"))
            .thenAnswer((_) async => Future.value(ritem));
        expect(
          itemCubit.fromJson(itemCubit.toJson(itemCubit.state)!),
          itemCubit.state,
        );
      });
    });

    group('right states', () {
      test('is in ItemFetched after item is returned', () async {
        final itemCubit = ItemCubit(itemRepository);
        when(() => itemRepository.getItem("id"))
            .thenAnswer((_) async => Future.value(ritem));
        await itemCubit.fetchItem("id");
        expect(
          ItemFetchedState(item: ritem),
          itemCubit.state,
        );
      });
      test('is in FailureState after exception is thrown', () async {
        final itemCubit = ItemCubit(itemRepository);
        when(() => itemRepository.getItem("id"))
            .thenAnswer((_) async => throw Exception("crash"));
        await itemCubit.fetchItem("id");
        expect(
          FailureState(errorMessage: "crash"),
          itemCubit.state,
        );
      });
    });
    group('pagination', () {
      test(
          'fetchItems with pagination=false should clear itemList and reset skip to 0',
          () async {
        final bloc = ItemCubit(itemRepository..setItemList([]));
        when(() => itemRepository.getItemList()).thenAnswer((_) => []);
        when(() => itemRepository.getItems(any(), false))
            .thenAnswer((_) => Future.value(0));
        await bloc.fetchItems(pagination: false);
        expect(bloc.skip, 0);
        expect(bloc.itemList, isEmpty);
      });
      test(
          'fetchItems with pagination=true should append items to itemList and update skip',
          () async {
        final bloc = ItemCubit(itemRepository);
        when(() => itemRepository.getItemList()).thenAnswer((_) => [ritem]);
        when(() => itemRepository.getItems(any(), true))
            .thenAnswer((_) => Future.value(1));
        await bloc.fetchItems(pagination: true);
        expect(bloc.skip, isNot(0));
        expect(bloc.itemList, isNotEmpty);
        when(() => itemRepository.getItemList())
            .thenAnswer((_) => [ritem, ritem2]);
        when(() => itemRepository.getItems(any(), true))
            .thenAnswer((_) => Future.value(2));
        await bloc.fetchItems(pagination: true);
        expect(bloc.skip, 2);
        expect(bloc.itemList, [ritem, ritem2]);
      });
    });
  });
}
