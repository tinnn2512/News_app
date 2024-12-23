import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model/article_model.dart';

import '../views/article_view/article_view.dart';

class NewsTile extends StatefulWidget {
  final ArticleModel article;

  final String monName;
  const NewsTile({
    super.key,
    required this.article,
    required this.monName,
  });

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // AppProvider appProvider =
        //     Provider.of<AppProvider>(context, listen: false);
        // await appProvider.getNewsDetail(id: widget.article.id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      article: widget.article,
                    )));
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                      imageUrl: widget.article.urlToImage != null
                          ? widget.article.urlToImage!
                          : 'https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg',
                      height: 60,
                      width: 110,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) {
                        return SizedBox(
                          width: 110,
                          height: 60,
                          child: Image.network(
                            "https://st3.depositphotos.com/23594922/31822/v/600/depositphotos_318221368-stock-illustration-missing-picture-page-for-website.jpg",
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.article.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.article.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 12),
                      ),
                      Text(
                        "${widget.monName} ${widget.article.publshedAt.day}.${widget.article.publshedAt.year}",
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
