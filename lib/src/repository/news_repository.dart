
import 'package:app_notice_bloc_flutter/src/model/article.dart';

abstract class NewsRepositoryBase{
  Future <List<Article>> topHeadLines(String country);
}
