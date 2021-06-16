import 'package:flutter/material.dart';
import 'package:news_app_flutter/models/news.model.dart';

class NewsListView extends StatefulWidget {
  final List<NewsModel> articles;
  NewsListView({this.articles});
  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
         shrinkWrap: true,
        itemCount: widget.articles.length,
        itemBuilder: (_, i) {
          return renderNews(widget.articles[i]);
        });
  }
}

Widget renderNews(NewsModel article) {
  return Card(
    child: Column(
      children: <Widget>[
        ListTile(
          title: Text(article.title),
        ),
        Image.network(article.urlToImage, fit: BoxFit.cover, width: 1000.0),
      ],
    ),
  );
}
