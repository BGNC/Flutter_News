import 'package:flutter/material.dart';
import 'package:news_app_flutter/models/news.model.dart';
import 'package:news_app_flutter/screens/web.view.screen.dart';
import 'package:news_app_flutter/widget/square.image.dart';

class DetailScreen extends StatefulWidget {
  final NewsModel article;
  DetailScreen({this.article});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  _showDetailScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return WevViewScreen(article: widget.article);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.widget.article.author==null ? "Kaynak Belirtilmemiş" : this.widget.article.author,
          style: TextStyle(color: Color(0xffebedee)),),
        centerTitle: true,
        
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: SquareImage(imageUrl: this.widget.article.urlToImage,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                titleEdit(this.widget.article.title),
                style: TextStyle(
                  color: Color(0xffebedee),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 2.0))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                this.widget.article.description,
                style: TextStyle(
                  color: Color(0xffebedee),
                  fontSize: 16.0,
                  wordSpacing: 2.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: GestureDetector(
                onTap: (){
                  _showDetailScreen();
                },
                child: Text("Devamını Okumak İçin Tıklayınız",
                style: TextStyle(
                    color: Color(0xff4fc3f7),
                    fontSize: 18.0,
                    wordSpacing: 2.0,
                    fontWeight: FontWeight.bold)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

String titleEdit(String title){
    if(title!=null) {
      if(title.contains('-')){
        return title.split('-')[0];
      }
      else {
        return title;
      }
    }
    else {
      return title;
    } 
}