import 'dart:convert';
import 'package:http/http.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_provider/mobx_provider.dart';
import 'package:news_app_flutter/models/news.model.dart';

part 'NewsStore.g.dart';

class NewsStore = _NewsStore with _$NewsStore;

abstract class _NewsStore extends MobxBase with Store {

  @observable
  String country = "tr";

  @observable
  String category = "general";

  @observable
  bool callErr = false;

  @observable
  ObservableList<NewsModel> news = ObservableList<NewsModel>();

  @computed
  getSliderTopHeadlines() {
    return this.news.take(9).toList();
  }

  @computed
  getListViewTopHeadlines() {
    return this.news.skip(9).toList();
  }

  @computed
  getListViewAll() {
    return this.news.toList();
  }

  @action
  getNews(int page) async {
    //String apiKey="e0b43a3fc6854e7e90749cdc8c78dee6"; //1
    String apiKey = "39d88958ff924452af15c15ce7fa9693"; //2

    String url = 'https://newsapi.org/v2/top-headlines?country=$country';
    url += '&category=$category';
    url += '&apiKey=$apiKey';
    url += '&pagesize=15';
    url += '&page=$page';

    try {

      if (page == 1) {
          this.news.clear();
        }

      Response response = await get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Iterable list = result["articles"];
        //print( result["articles"]);
        print('sayfa ' + page.toString());
        
        if (list.length > 0) {
          list
              .map((article) => this.news.add(NewsModel.fromJson(article)))
              .toList();
        }
      } else {
        //throw Exception(response.statusCode.toString()+" -> Failed to get topheadlines");
        print(response.statusCode.toString()+", page "+page.toString()+ " , Failed to get topheadlines");
      }
    } catch (e) {
      this.callErr = true;
      print('düstü ->'+e.toString());
    }
  }

  @override
  void dispose() {}
}
