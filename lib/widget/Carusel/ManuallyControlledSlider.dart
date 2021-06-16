import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/models/news.model.dart';
import 'package:news_app_flutter/screens/detail.screen.dart';

class ManuallyControlledSlider extends StatefulWidget {
  final List<NewsModel> articles;
  ManuallyControlledSlider({this.articles});

  @override
  State<StatefulWidget> createState() {
    return _ManuallyControlledSliderState();
  }
}

class _ManuallyControlledSliderState extends State<ManuallyControlledSlider> {
  final CarouselController _controller = CarouselController();

  _showDetailScreen(article) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DetailScreen(article: article);
    }));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            items: widget.articles
                .map((item) => GestureDetector(
                      onTap: () {
                        _showDetailScreen(item);
                      },
                      child: Container(
                        child: Container(
                          //margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                              //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                            children: <Widget>[
                              Image.network(
                                item.urlToImage,
                                fit: BoxFit.cover,
                                width: 1000.0,
                              ),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(230, 0, 0, 0),
                                        Color.fromARGB(0, 0, 0, 0)
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  child: Text(
                                    titleEdit(item.title),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: 230,
              autoPlay: true,
              viewportFraction: 1,
              //aspectRatio: MediaQuery.of(context).size.aspectRatio,
            ),
            carouselController: _controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Flexible(
              //   child: RaisedButton(
              //     onPressed: () => _controller.previousPage(),
              //     child: Text('←'),
              //   ),
              // ),
              // Flexible(
              //   child: RaisedButton(
              //     onPressed: () => _controller.nextPage(),
              //     child: Text('→'),
              //   ),
              // ),
              ...Iterable<int>.generate(widget.articles.length).map(
                (int pageIndex) => Flexible(
                  child: RaisedButton(
                    color: Color(0xff102027),
                    onPressed: () => _controller.animateToPage(pageIndex),
                    child: Text(
                      "${pageIndex + 1}",
                      style: TextStyle(color: Color(0xff4fc3f7)),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
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

//GestureDetector
