import 'package:json_annotation/json_annotation.dart';

part 'category_image_model.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CategoryImageModel {
  @JsonKey(name: 'img_1x1_url')
  String? imageSquareUrl;
  @JsonKey(name: 'img_16x9_url')
  String? imageWideUrl;
  CategoryImageModel({
    this.imageSquareUrl,
    this.imageWideUrl,
  });

  factory CategoryImageModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryImageModelToJson(this);

  @override
  String toString() =>
      'CategoryImageModel(imageSquareUrl: $imageSquareUrl, imageWideUrl: $imageWideUrl)';
}
