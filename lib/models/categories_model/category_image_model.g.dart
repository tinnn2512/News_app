// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryImageModel _$CategoryImageModelFromJson(Map<String, dynamic> json) =>
    CategoryImageModel(
      imageSquareUrl: json['img_1x1_url'] as String?,
      imageWideUrl: json['img_16x9_url'] as String?,
    );

Map<String, dynamic> _$CategoryImageModelToJson(CategoryImageModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('img_1x1_url', instance.imageSquareUrl);
  writeNotNull('img_16x9_url', instance.imageWideUrl);
  return val;
}
