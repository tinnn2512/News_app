import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../../widgets/news_tile.dart';

class SelectedCategoriesNews extends StatefulWidget {
  final String newsCategory;

  const SelectedCategoriesNews({super.key, required this.newsCategory});

  @override
  _SelectedCategoriesNewsState createState() => _SelectedCategoriesNewsState();
}

class _SelectedCategoriesNewsState extends State<SelectedCategoriesNews> {
  bool _loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  void getNews() async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    await appProvider.getNews(category: widget.newsCategory);
    // appProvider.categoryList = news.news;
    setState(() {
      _loading = false;
    });
  }

  List months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Newscape",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(
                  Icons.share,
                )),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.only(top: 16),
              child: ListView.builder(
                  itemCount: appProvider.categoryList.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    int monName =
                        appProvider.categoryList[index].publshedAt.month;

                    // return Container();
                    return NewsTile(
                      monName: months[monName - 1],
                      article: appProvider.categoryList[index],
                    );
                  }),
            ),
    );
  }
}
