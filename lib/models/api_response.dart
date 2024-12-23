import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, includeIfNull: false)
class ApiResponse<TModel> {
  TModel? data;
  String? message;

  ApiResponse({this.data, this.message});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    TModel Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(TModel value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  @override
  String toString() {
    return 'ApiResponse(data: $data, message: $message)';
  }
}
