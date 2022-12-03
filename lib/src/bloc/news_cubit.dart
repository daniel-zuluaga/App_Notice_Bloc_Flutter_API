import 'package:app_notice_bloc_flutter/src/model/article.dart';
import 'package:app_notice_bloc_flutter/src/provider/news_provider.dart';
import 'package:app_notice_bloc_flutter/src/repository/news_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {

  
  final NewsRepositoryBase _repository;

  NewsCubit(this._repository): super(NewsInitialState());

  Future<void> loadTopNews({String country = "us"}) async {
    try{
      emit(NewsLoadingState());

      final news = await _repository.topHeadLines(country);

      emit(NewsLoadCompletedState(news));
    } on Exception catch (e){
    if(e is MissingApiKeyException){
      emit(NewsErrorState("Please check the API key"));
    }
    else if(e is ApiKeyInvalidException){
      emit(NewsErrorState("The API key is invalid"));
    }
    else {
      emit(NewsErrorState("Unknow error"));
    } 
  }
  }
  
}

abstract class NewsState extends Equatable {

  @override
  List<Object> get props => [];
  
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadCompletedState extends NewsState {
  final List<Article> news;

  NewsLoadCompletedState(this.news);

  @override
  List<Object> get props => [news];

}

class NewsErrorState extends NewsState {
  final String message;

  NewsErrorState(this.message);

  @override
  List<Object> get props => [message];

}


