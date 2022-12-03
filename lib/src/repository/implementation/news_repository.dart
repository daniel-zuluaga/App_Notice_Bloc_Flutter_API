import 'package:app_notice_bloc_flutter/src/model/article.dart';
import 'package:app_notice_bloc_flutter/src/provider/news_provider.dart';
import 'package:app_notice_bloc_flutter/src/repository/news_repository.dart';

class NewsRepository extends NewsRepositoryBase{
  final NewsProvider _provider;

  NewsRepository(this._provider);

  @override
  Future<List<Article>> topHeadLines(String country) => 
    _provider.topHeadLines(country);

}