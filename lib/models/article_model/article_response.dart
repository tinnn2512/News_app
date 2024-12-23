import 'package:json_annotation/json_annotation.dart';

import 'package:news_app/models/article_model/article_model.dart';

part 'article_response.g.dart';

@JsonSerializable()
class ArticleResponse {
  List<ArticleModel> items;
  int? total;
  @JsonKey(defaultValue: 1)
  int? page;
  int? size;
  int? pages;

  ArticleResponse({
    required this.items,
    this.total,
    this.page,
    this.size,
    this.pages,
  });

  factory ArticleResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ArticleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);

  @override
  String toString() {
    return 'ArticleResponse(items: $items, total: $total, page: $page, size: $size, pages: $pages)';
  }
}
