import 'package:app_notice_bloc_flutter/src/model/article.dart';
import 'package:app_notice_bloc_flutter/src/navigation/routes.dart';
import 'package:app_notice_bloc_flutter/src/repository/news_repository.dart';
import 'package:app_notice_bloc_flutter/src/ui/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../bloc_test/news_cubit_test.mocks.dart';

void main() {
  final article1 = Article(title: "Prueba 1", author: "Carlos");
  final article12 = Article(title: "Prueba 2", author: "Cristian");

  final mockRepo = MockNewsRepositoryBase();

  setUp((){
    when(mockRepo.topHeadLines(any))
      .thenAnswer((_) async => [article1, article12]);
  
  
  });

  testWidgets("News screen loads correctly", (WidgetTester tester) async {

    await tester.pumpWidget(RepositoryProvider<NewsRepositoryBase>(
      create: (context) => mockRepo,
      child: MaterialApp(
        home: Builder(
          builder: (context){
            return NewsScreen.create(context);
          }
        ),
      ),
    ));

    await tester.pumpAndSettle();
    expect(find.text("Top of News Notice"), findsOneWidget);
    expect(find.text("Prueba 1"), findsOneWidget);
    expect(find.text("Prueba 2"), findsOneWidget);
  
  });

  testWidgets("Navigate to details correctly", (WidgetTester tester) async {

    await tester.pumpWidget(
      RepositoryProvider<NewsRepositoryBase>(
      create: (context) => mockRepo,
      child: MaterialApp(
        onGenerateRoute: (settings) => Routes.routes(settings),
      ),
    ));


    await tester.pumpAndSettle();
    await tester.tap(find.text("Prueba 1"));
    await tester.pumpAndSettle();


    expect(find.text("Notice News with details"), findsOneWidget);
    expect(find.text("Prueba 1"), findsOneWidget);
    expect(find.text("More details"), findsOneWidget);
  
  });

}
