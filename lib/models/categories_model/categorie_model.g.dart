// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categorie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesModel _$CategoriesModelFromJson(Map<String, dynamic> json) =>
    CategoriesModel(
      id: json['id'] as String,
      categorieName: json['name'] as String,
      slug: json['slug'] as String?,
      parentId: json['parent_id'] as String?,
      total_posts: (json['total_posts'] as num?)?.toInt() ?? 0,
      subcategories: (json['subcategories'] as List<dynamic>?)
              ?.map((e) => CategoriesModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      img: json['img'] == null
          ? null
          : CategoryImageModel.fromJson(json['img'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoriesModelToJson(CategoriesModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.categorieName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('slug', instance.slug);
  writeNotNull('parent_id', instance.parentId);
  writeNotNull('total_posts', instance.total_posts);
  writeNotNull(
      'subcategories', instance.subcategories?.map((e) => e.toJson()).toList());
  writeNotNull('img', instance.img?.toJson());
  return val;
}
