
import 'package:app_notice_bloc_flutter/src/bloc/news_cubit.dart';
import 'package:app_notice_bloc_flutter/src/model/article.dart';
import 'package:app_notice_bloc_flutter/src/provider/news_provider.dart';
import 'package:app_notice_bloc_flutter/src/repository/news_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'news_cubit_test.mocks.dart';


@GenerateMocks([NewsRepositoryBase])
void main() {

  group("Cubit test", (){

    final article = Article(title: "Test", author: "Daniel Zuluaga");
    final mockRepo = MockNewsRepositoryBase();

    blocTest<NewsCubit, NewsState>(
      'News will be loaded correctly',
      build: () {
        when(mockRepo.topHeadLines(any)).thenAnswer((_) async => [article]);
        return NewsCubit(mockRepo);
      },
      act: (cubit) async => cubit.loadTopNews(),
      expect: () => [
        NewsLoadingState(),
        NewsLoadCompletedState([article])
      ],
    );

    blocTest<NewsCubit, NewsState>(
      'ApiKey exception is handled correctly',
      build: () {
        when(mockRepo.topHeadLines(any)).thenAnswer((_) async => throw ApiKeyInvalidException());
        return NewsCubit(mockRepo);
      },
      act: (cubit) async => cubit.loadTopNews(),
      expect: () => [
        NewsLoadingState(),
        NewsErrorState("The API key is invalid")
      ],
    );

  });
}
