import 'package:json_annotation/json_annotation.dart';

import 'package:news_app/models/categories_model/categorie_model.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse {
  List<CategoriesModel> items;
  int? total;
  @JsonKey(defaultValue: 1)
  int? page;
  int? size;
  int? pages;

  CategoryResponse({
    required this.items,
    this.total,
    this.page,
    this.size,
    this.pages,
  });

  factory CategoryResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);

  @override
  String toString() {
    return 'CategoryResponse(items: $items, total: $total, page: $page, size: $size, pages: $pages)';
  }
}
