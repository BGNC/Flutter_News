import 'package:flutter/material.dart';
import 'package:news_app_flutter/models/news.model.dart';
import 'package:webview_flutter/webview_flutter.dart';
 
class WevViewScreen extends StatelessWidget {
  
  final NewsModel article;
  WevViewScreen({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(article.author==null ? "Kaynak Belirtilmemiş" : article.author),
        centerTitle: true,
      ),
      body:WebView(
        initialUrl: article.url,
        javascriptMode: JavascriptMode.unrestricted,
      ) ,
    );
  }
}
