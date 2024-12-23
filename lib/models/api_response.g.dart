// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<TModel> _$ApiResponseFromJson<TModel>(
  Map<String, dynamic> json,
  TModel Function(Object? json) fromJsonTModel,
) =>
    ApiResponse<TModel>(
      data: _$nullableGenericFromJson(json['data'], fromJsonTModel),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ApiResponseToJson<TModel>(
  ApiResponse<TModel> instance,
  Object? Function(TModel value) toJsonTModel,
) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', _$nullableGenericToJson(instance.data, toJsonTModel));
  writeNotNull('message', instance.message);
  return val;
}

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
