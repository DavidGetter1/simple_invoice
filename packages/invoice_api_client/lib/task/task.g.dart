// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task<T> _$TaskFromJson<T>(Map<String, dynamic> json) => Task<T>(
      method: $enumDecode(_$MethodEnumMap, json['method']),
      data: Task._fromJson((json['data'] ?? {}) as Object?),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TaskToJson<T>(Task<T> instance) => <String, dynamic>{
      'method': _$MethodEnumMap[instance.method]!,
      'data': Task._toJson(instance.data),
      'id': instance.id,
    };

const _$MethodEnumMap = {
  Method.DELETE: 'DELETE',
  Method.UPDATE: 'UPDATE',
  Method.INSERT: 'INSERT',
};
