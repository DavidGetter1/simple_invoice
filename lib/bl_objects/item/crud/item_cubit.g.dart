// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemFetchedState _$ItemFetchedStateFromJson(Map<String, dynamic> json) =>
    ItemFetchedState(
      item: Item.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemFetchedStateToJson(ItemFetchedState instance) =>
    <String, dynamic>{
      'item': instance.item.toJson(),
    };

OperationCompletedState _$OperationCompletedStateFromJson(
        Map<String, dynamic> json) =>
    OperationCompletedState(
      itemList: (json['itemList'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OperationCompletedStateToJson(
        OperationCompletedState instance) =>
    <String, dynamic>{
      'itemList': instance.itemList.map((e) => e.toJson()).toList(),
    };

FailureState _$FailureStateFromJson(Map<String, dynamic> json) => FailureState(
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$FailureStateToJson(FailureState instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
    };
