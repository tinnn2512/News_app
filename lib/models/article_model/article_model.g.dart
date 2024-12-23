// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) => ArticleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      body: json['body'] as String?,
      source: json['source'] as String?,
      author: json['author'] as String?,
      publshedAt: DateTime.parse(json['published_at'] as String),
      urlToImage: json['img_url'] as String?,
      articleUrl: json['url'] as String,
    );

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('author', instance.author);
  writeNotNull('description', instance.description);
  writeNotNull('body', instance.body);
  writeNotNull('source', instance.source);
  writeNotNull('img_url', instance.urlToImage);
  val['published_at'] = instance.publshedAt.toIso8601String();
  val['url'] = instance.articleUrl;
  return val;
}
