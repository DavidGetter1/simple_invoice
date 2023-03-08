// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCreatedState _$ItemCreatedStateFromJson(Map<String, dynamic> json) =>
    ItemCreatedState(
      id: json['id'] as String,
    );

Map<String, dynamic> _$ItemCreatedStateToJson(ItemCreatedState instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

ItemFetchedState _$ItemFetchedStateFromJson(Map<String, dynamic> json) =>
    ItemFetchedState(
      item: ItemDTOReceive.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemFetchedStateToJson(ItemFetchedState instance) =>
    <String, dynamic>{
      'item': instance.item.toJson(),
    };

ItemListFetchedState _$ItemListFetchedStateFromJson(
        Map<String, dynamic> json) =>
    ItemListFetchedState(
      itemList: (json['itemList'] as List<dynamic>)
          .map((e) => ItemDTOReceive.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastN: json['lastN'] as int,
    );

Map<String, dynamic> _$ItemListFetchedStateToJson(
        ItemListFetchedState instance) =>
    <String, dynamic>{
      'lastN': instance.lastN,
      'itemList': instance.itemList.map((e) => e.toJson()).toList(),
    };

FailureState _$FailureStateFromJson(Map<String, dynamic> json) => FailureState(
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$FailureStateToJson(FailureState instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
    };
