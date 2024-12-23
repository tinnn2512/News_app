import 'package:dio/dio.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/models/api_response.dart';
import 'package:news_app/models/article_model/article_model.dart';
import 'package:news_app/models/article_model/article_response.dart';
import 'package:news_app/models/categories_model/category_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: endpoint)
abstract class RestApiClient {
  factory RestApiClient(Dio dio, {String baseUrl}) = _RestApiClient;

  @GET("/api/v1/news/posts")
  Future<ApiResponse<ArticleResponse>> getPosts(
      @Queries() Map<String, dynamic> queries);

  @GET("/api/v1/news/categories")
  Future<ApiResponse<CategoryResponse>> getCategories(
      @Queries() Map<String, dynamic> queries);

  @GET("/api/v1/news/posts/{id}")
  Future<ApiResponse<ArticleModel>> getNewsDetail(@Path("id") String id);
}
