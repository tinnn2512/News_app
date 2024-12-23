import 'package:json_annotation/json_annotation.dart';

import 'category_image_model.dart';

part 'categorie_model.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CategoriesModel {
  String id;
  @JsonKey(name: 'name')
  String categorieName;
  String? slug;
  @JsonKey(name: 'parent_id')
  String? parentId;
  @JsonKey(defaultValue: 0)
  int? total_posts;
  @JsonKey(defaultValue: [])
  List<CategoriesModel>? subcategories;
  CategoryImageModel? img;
  CategoriesModel({
    required this.id,
    required this.categorieName,
    this.slug,
    this.parentId,
    this.total_posts,
    this.subcategories,
    this.img,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesModelToJson(this);

  factory CategoriesModel.fromDocument(Map<String, dynamic> map) {
    return CategoriesModel(
      id: map['id'],
      categorieName: map['name'],
    );
  }

  @override
  String toString() {
    return 'CategoriesModel(id: $id, categorieName: $categorieName, slug: $slug, parentId: $parentId, total_posts: $total_posts, subcategories: $subcategories, img: $img)';
  }
}
