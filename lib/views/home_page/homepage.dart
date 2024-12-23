import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:news_app/provider/app_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/news_tile.dart';
import '../article_view/article_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;

  void getNews() async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.getNews();
    setState(() {
      _loading = false;
    });
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    _loading = true;
    super.initState();
    EasyLoading.show(status: 'Loading...');

    getNews();
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
  int mon = 0;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    if (appProvider.newsList.isNotEmpty) {
      setState(() {
        mon = appProvider.newsList.first.publshedAt.month;
      });
    }
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
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(
        //           MaterialPageRoute(
        //             builder: (ctx) => const SearchScreen(),
        //           ),
        //         );
        //       },
        //       icon: const Icon(
        //         Icons.search,
        //         color: Colors.black,
        //       ))
        // ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleView(
                                      // list: appProvider.newsList,
                                      article: appProvider.newsList.first,
                                    )));
                      },
                      child: appProvider.newsList.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: MediaQuery.of(context).size.width,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                alignment: Alignment.bottomCenter,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(6),
                                        bottomLeft: Radius.circular(6))),
                                child: Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: CachedNetworkImage(
                                        imageUrl: appProvider
                                                .newsList.first.urlToImage ??
                                            'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
                                        height: 300,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, bottom: 24.0, right: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            appProvider.newsList.first.title,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 6.0,
                                          ),
                                          Text(
                                            "${months[mon - 1]} ${appProvider.newsList.first.publshedAt.day}.${appProvider.newsList.first.publshedAt.year}",
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          : const Center(
                              child: Text('No item found'),
                            ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: appProvider.newsList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            if (appProvider.newsList.first.urlToImage ==
                                appProvider.newsList[index].urlToImage) {
                              return Container();
                            } else {
                              int monName =
                                  appProvider.newsList[index].publshedAt.month;

                              return NewsTile(
                                article: appProvider.newsList[index],
                                monName: months[monName - 1],
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
