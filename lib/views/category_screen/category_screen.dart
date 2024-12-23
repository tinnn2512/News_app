import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:provider/provider.dart';

import '../../models/categories_model/categorie_model.dart';
import '../selected_categories_news/selected_categories_news.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoriesModel> categories = [];
  bool _loading = false;

  @override
  void initState() {
    categories = Provider.of<AppProvider>(context, listen: false).myCategories;
    _loading = true;

    super.initState();
    getCategories();
  }

  void getCategories() async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.getCategories();
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Category",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: appProvider.myCategories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 0.0, mainAxisSpacing: 0.0),
        itemBuilder: (BuildContext context, int index) {
          return _loading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectedCategoriesNews(
                            newsCategory: appProvider.myCategories[index].id,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: CachedNetworkImage(
                        imageUrl: appProvider
                                .myCategories[index].img!.imageSquareUrl ??
                            'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
                        height: 300,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) {
                          return Center(
                            child: SizedBox(
                              height: 300,
                              child: Image.network(
                                "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12.0),
                    //       image: DecorationImage(
                    //         fit: BoxFit.cover,
                    //         image: AssetImage(
                    //             "assets/${categories[index].imageAssetUrl}.jpg"),
                    //       ),
                    //     ),
                    //     alignment: Alignment.bottomCenter,
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       height: 60,
                    //       // width: 120,
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5),
                    //           color: Colors.black26),
                    //       child: Text(
                    //         categories[index].categorieName,
                    //         textAlign: TextAlign.center,
                    //         style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w500),
                    //       ),
                    //     )),
                  ),
                );
          // return Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: CategoryCard(
          //     imageAssetUrl: categories[index].imageAssetUrl,
          //     categoryName: categories[index].categorieName,
          //   ),
          // );
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  const CategoryCard(
      {super.key, required this.imageAssetUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectedCategoriesNews(
              newsCategory: categoryName.toLowerCase(),
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image(
              image: AssetImage("assets/$imageAssetUrl.jpg"),
              fit: BoxFit.cover,
            ),
            // child: CachedNetworkImage(
            //   imageUrl: imageAssetUrl,
            //   // height: 400,
            //   // width: 120,
            //   fit: BoxFit.cover,
            // ),
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            // width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.black26),
            child: Text(
              categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
