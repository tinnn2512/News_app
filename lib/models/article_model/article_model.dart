import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class ArticleModel {
  String id;
  String title = '';
  String? author;
  String? description;
  String? body;
  String? source;
  @JsonKey(name: 'img_url')
  String? urlToImage;
  @JsonKey(name: 'published_at')
  DateTime publshedAt;
  @JsonKey(name: 'url')
  String articleUrl;

  ArticleModel({
    required this.id,
    required this.title,
    this.description,
    this.body,
    this.source,
    required this.author,
    required this.publshedAt,
    required this.urlToImage,
    required this.articleUrl,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);

  @override
  String toString() {
    return 'ArticleModel(id: $id, title: $title, author: $author, description: $description, body: $body, source: $source, urlToImage: $urlToImage, publshedAt: $publshedAt, articleUrl: $articleUrl)';
  }
}
