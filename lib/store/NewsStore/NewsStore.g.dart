// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewsStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewsStore on _NewsStore, Store {
  final _$countryAtom = Atom(name: '_NewsStore.country');

  @override
  String get country {
    _$countryAtom.reportRead();
    return super.country;
  }

  @override
  set country(String value) {
    _$countryAtom.reportWrite(value, super.country, () {
      super.country = value;
    });
  }

  final _$categoryAtom = Atom(name: '_NewsStore.category');

  @override
  String get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(String value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$newsAtom = Atom(name: '_NewsStore.news');

  @override
  ObservableList<NewsModel> get news {
    _$newsAtom.reportRead();
    return super.news;
  }

  @override
  set news(ObservableList<NewsModel> value) {
    _$newsAtom.reportWrite(value, super.news, () {
      super.news = value;
    });
  }

  final _$getNewsAsyncAction = AsyncAction('_NewsStore.getNews');

  @override
  Future getNews(int page) {
    return _$getNewsAsyncAction.run(() => super.getNews(page));
  }

  @override
  String toString() {
    return '''
country: ${country},
category: ${category},
news: ${news}
    ''';
  }
}
