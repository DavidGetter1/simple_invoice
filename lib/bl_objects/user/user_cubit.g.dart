// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCreatedState _$UserCreatedStateFromJson(Map<String, dynamic> json) =>
    UserCreatedState(
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserCreatedStateToJson(UserCreatedState instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UserFetchedState _$UserFetchedStateFromJson(Map<String, dynamic> json) =>
    UserFetchedState(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserFetchedStateToJson(UserFetchedState instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };

UserListFetchedState _$UserListFetchedStateFromJson(
        Map<String, dynamic> json) =>
    UserListFetchedState(
      userList: (json['userList'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastN: json['lastN'] as int,
    );

Map<String, dynamic> _$UserListFetchedStateToJson(
        UserListFetchedState instance) =>
    <String, dynamic>{
      'lastN': instance.lastN,
      'userList': instance.userList.map((e) => e.toJson()).toList(),
    };

FailureState _$FailureStateFromJson(Map<String, dynamic> json) => FailureState(
      errorMessage: json['errorMessage'] as String,
    );

Map<String, dynamic> _$FailureStateToJson(FailureState instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
    };
