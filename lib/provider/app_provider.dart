import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news_app/core/api_client.dart';
import 'package:news_app/core/injector.dart';

import '../models/article_model/article_model.dart';
import '../models/categories_model/categorie_model.dart';

class AppProvider with ChangeNotifier {
  String apiKey = "5489ab7d6a084aaf8996092233243ab5";
  List<ArticleModel> favouriteList = [];
  bool isLoading = false;

  void addFavouriteNews(ArticleModel articleModel) {
    favouriteList.add(articleModel);
    notifyListeners();
  }

  void removeFavouriteNews(ArticleModel articleModel) {
    favouriteList.remove(articleModel);
    notifyListeners();
  }

  List<CategoriesModel> myCategories = [];
  List<ArticleModel> newsList = [];

  Future<void> getNews({int? page, int? pageSize, String? category}) async {
    RestApiClient client = Injector().getClient();

    Map<String, dynamic> queries = {};
    queries['order'] = 'desc';
    queries['order_by'] = 'published_at';
    queries['q'] = '';
    queries['page'] = page ?? 1;
    queries['size'] = pageSize ?? 50;
    if (category != null) {
      categoryList.clear();
      queries['categories_filter'] = category;
    } else {
      newsList.clear();
    }
    client.getPosts(queries).then((it) {
      if (category != null) {
        categoryList.addAll(it.data!.items);
      } else {
        newsList.addAll(it.data!.items);
      }

      notifyListeners();
    }).onError((eror, st) {
      log(eror.toString(), stackTrace: st);

      EasyLoading.showError(
        'Has an error',
        duration: const Duration(seconds: 3),
        dismissOnTap: true,
      );
    });
  }

  ArticleModel? postDetail;

  Future<ArticleModel?> getNewsDetail({String id = ''}) async {
    RestApiClient client = Injector().getClient();
    postDetail = null;

    try {
      var response = await client.getNewsDetail(id);
      if (response.data != null) {
        postDetail = response.data!;
        notifyListeners();
        return response.data;
      }
    } catch (e) {
      EasyLoading.showError(
        'Has an error',
        duration: const Duration(seconds: 3),
        dismissOnTap: true,
      );
    }
    // client.getNewsDetail(id).then((it) {
    //   if (it.data != null) {
    //     postDetail = it.data!;
    //     notifyListeners();
    //   }
    // }).onError((eror, st) {
    //   log(eror.toString(), stackTrace: st);

    //   EasyLoading.showError(
    //     'Has an error',
    //     duration: const Duration(seconds: 3),
    //     dismissOnTap: true,
    //   );
    // });
    return null;
  }

  Future<void> getCategories({int? page, int? pageSize}) async {
    RestApiClient client = Injector().getClient();
    myCategories.clear();
    Map<String, dynamic> queries = {};
    queries['order'] = 'desc';
    queries['order_by'] = 'published_at';
    queries['q'] = '';
    queries['page'] = page ?? 1;
    queries['size'] = pageSize ?? 50;
    client.getCategories(queries).then((it) {
      myCategories.addAll(it.data!.items);
      notifyListeners();
    }).onError((eror, st) {
      log(eror.toString(), stackTrace: st);

      EasyLoading.showError(
        'Has an error',
        duration: const Duration(seconds: 3),
        dismissOnTap: true,
      );
    });
  }

  List<ArticleModel> searchNews = [];

  Future<void> getSearchNews(String query) async {
    // searchNews.clear();
    // String url =
    //     "https://newsapi.org/v2/everything?q=${query.toLowerCase()}&from=2022-03-13&to=2022-03-13&sortBy=popularity&apiKey=$apiKey";
    // var uri = Uri.parse(url);
    // var response = await http.get(uri);

    // var jsonData = jsonDecode(response.body);

    // if (jsonData['status'] == "ok") {
    //   jsonData["articles"].forEach((element) {
    //     if (element['urlToImage'] != null && element['description'] != null) {
    //       ArticleModel article = ArticleModel.fromDocument(element);
    //       searchNews.add(article);
    //     }
    //   });
    // }
  }

  List<ArticleModel> categoryList = [];

  List<String> newsVideo = [
    "ulWYcd6Ojyc",
    "9zsv1XX-qT0",
    "fBNv0AltbLw",
    "llzlaPHeQ5A",
    "JpEN_7TEZSU",
    "58IsEG68L-A",
    "5l8_SRRDBwE",
    "9QW7Nfg4d9I",
  ];

  Future<void> getNewsForCategory(String category) async {
    // categoryList.clear();
    // String url =
    //     "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=$apiKey";
    // var uri = Uri.parse(url);
    // var response = await http.get(uri);

    // var jsonData = jsonDecode(response.body);

    // if (jsonData['status'] == "ok") {
    //   jsonData["articles"].forEach((element) {
    //     if (element['urlToImage'] != null && element['description'] != null) {
    //       ArticleModel article = ArticleModel.fromDocument(element);

    //       categoryList.add(article);
    //     }
    //   });
    // }
    // return news;
  }
}
