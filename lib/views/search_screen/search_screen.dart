import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../../widgets/news_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool loading = false;
  void getNews() async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    //  appProvider.searchNews.clear();
    setState(() {
      loading = true;
    });
    // SearchNews news = SearchNews();
    await appProvider.getSearchNews(searchController.text);
    setState(() {
      loading = false;
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
  int mon = 0;

  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            height: 45,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[300],
            ),
            child: TextField(
              focusNode: focusNode,
              controller: searchController,
              onEditingComplete: () {
                if (searchController.text.isNotEmpty) {
                  getNews();
                  FocusScope.of(context).unfocus();
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
              decoration: InputDecoration(
                suffixIcon: searchController.text.isEmpty
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            FocusScope.of(context).unfocus();
                          });
                        },
                        icon: const Icon(Icons.close)),
                border: InputBorder.none,
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          loading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ))
              : searchController.text.isEmpty && appProvider.searchNews.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: const Center(
                        child: Text("No Found"),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: appProvider.searchNews.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            int monName =
                                appProvider.searchNews[index].publshedAt.month;

                            // return Container();
                            return NewsTile(
                              monName: months[monName - 1],
                              article: appProvider.searchNews[index],
                            );
                          }),
                    ),
        ],
      ),
    );
  }
}
