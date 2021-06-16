import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_provider/mobx_provider.dart';
import 'package:news_app_flutter/models/news.model.dart';
import 'package:news_app_flutter/models/category.dart';
import 'package:news_app_flutter/screens/detail.screen.dart';
import 'package:news_app_flutter/store/NewsStore/NewsStore.dart';
import 'package:news_app_flutter/widget/Carusel/ManuallyControlledSlider.dart';

const Map<String, String> Countries = {
  "Türkiye": "tr",
  "Ukrayna": "ua",
  "Almanya": "de",
  "İngiltere": "gb",
  "Fransa": "fr",
  "Belçika": "be",
  "Rusya": "ru",
  "Amerika": "us",
};

const List<Category> categories = const <Category>[
  const Category(id: 'general', name: "GÜNDEM"),
  const Category(id: 'entertainment', name: "MAGAZİN"),
  const Category(id: 'sport', name: "SPOR"),
  const Category(id: 'health', name: "SAĞLIK"),
  const Category(id: 'business', name: "İŞ"),
  const Category(id: 'technology', name: "TEKNOLOJİ"),
];

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  int page = 1;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobxStatefulProvider<NewsStore>(
        initFunction: (store) => store.getNews(page),
        builder: (context, store) {
          _refresh() {
            page = 1;
            store.getNews(page);
          }

          _loadData(newPage) async {
            if (newPage <= 6) {
              store.getNews(newPage);
            }
            setState(() {
              isLoading = false;
            });
            await Future.delayed(const Duration(seconds: 1), () {});
          }

          _scrollController.addListener(() {
            if (_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent &&
                !_scrollController.position.outOfRange) {
              page++;

              setState(() {
                isLoading = true;
              });

              _loadData(page);
            }
          });

          return DefaultTabController(
            length: categories.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Dünyadan Haberler'),
                actions: <Widget>[
                  PopupMenuButton(
                    onSelected: (country) {
                      store.country = Countries[country];
                      //print(newsStore.country);
                      _refresh();
                    },
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (_) {
                      return Countries.keys
                          .map((e) => PopupMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList();
                    },
                  )
                ],
                bottom: TabBar(
                  indicatorColor: Color(0xff4fc3f7),
                  indicatorWeight: 4.0,
                  labelColor: Color(0xff4fc3f7),
                  unselectedLabelColor: Color(0xffebedee),
                  onTap: (index) {
                    store.category = categories[index].id;
                    //print(categories[index].id);
                    _refresh();
                  },
                  isScrollable: true,
                  tabs: categories.map((Category category) {
                    return Tab(
                      text: category.name,
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: categories.map((Category category) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 1));
                      _refresh();
                    },
                    child: ListView(
                      controller: _scrollController,
                      children: <Widget>[
                        Observer(
                          builder: (_) => ManuallyControlledSlider(
                              articles: store.getSliderTopHeadlines()),
                        ),
                        Observer(
                          builder: (_) => ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: store.getListViewTopHeadlines().length,
                              itemBuilder: (_, i) {
                                return renderNews(context,
                                    store.getListViewTopHeadlines()[i]);
                              }),
                        ),
                        Container(
                          height: isLoading ? 50.0 : 0,
                          color: Colors.transparent,
                          child: Center(
                            child: new CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}

Widget renderNews(context, NewsModel article) {
  _showDetailScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DetailScreen(article: article);
    }));
  }

  return Card(
    color: Color(0xff102027),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            title: Text(
              titleEdit(article.title),
              style: TextStyle(color: Color(0xffebedee)),
            ),
            onTap: () {
              _showDetailScreen();
            },
          ),
        ),
        GestureDetector(
            onTap: () {
              _showDetailScreen();
            },
            child: Image.network(article.urlToImage,
                fit: BoxFit.contain, width: 1000.0)),
      ],
    ),
  );
}

String titleEdit(String title) {
  if (title != null) {
    if (title.contains('-')) {
      return title.split('-')[0];
    } else {
      return title;
    }
  } else {
    return title;
  }
}
