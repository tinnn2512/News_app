import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:html_viewer_elite/html_viewer_elite.dart';
import 'package:provider/provider.dart';

import 'package:news_app/models/article_model/article_model.dart';
import 'package:news_app/provider/app_provider.dart';

class ArticleView extends StatefulWidget {
  final ArticleModel article;

  const ArticleView({
    super.key,
    required this.article,
  });

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: 'Loading data...', dismissOnTap: true);
    getNewsDetail();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    super.dispose();
  }

  getNewsDetail() async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    await appProvider.getNewsDetail(id: widget.article.id);

    EasyLoading.dismiss();
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: widget.article.title,
      linkUrl: widget.article.urlToImage ??
          'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
    );
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
    mon = widget.article.publshedAt.month;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
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
        actions: [
          IconButton(
            onPressed: () async {
              await share();
            },
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Container(
              height: 300,
              color: Colors.red,
              child: CachedNetworkImage(
                  imageUrl: widget.article.urlToImage ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) {
                    return SizedBox(
                      width: 110,
                      height: 60,
                      // color: Colors.red,
                      child: Image.network(
                        "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    "${months[mon - 1]} ${widget.article.publshedAt.day}.${widget.article.publshedAt.year}",
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  // Body
                  if (appProvider.postDetail != null) ...[
                    // SizedBox(
                    //   height: 300,
                    //   child: WebViewWidget(
                    //     controller: _controller,
                    //   ),
                    // )
                    Html(
                      data: appProvider.postDetail!.body ?? '',
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text("Source: ${appProvider.postDetail!.source}")
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
