import 'package:app_notice_bloc_flutter/src/navigation/routes.dart';
import 'package:app_notice_bloc_flutter/src/provider/news_provider.dart';
import 'package:app_notice_bloc_flutter/src/repository/implementation/news_repository.dart';
import 'package:app_notice_bloc_flutter/src/repository/news_repository.dart';
import 'package:app_notice_bloc_flutter/src/ui/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  final newsProvider = NewsProvider();
  final newsRepository = NewsRepository(newsProvider);

  runApp(
    RepositoryProvider<NewsRepositoryBase>(
      create: (_) => newsRepository,
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      onGenerateRoute: (settings) => Routes.routes(settings),
      home: NewsScreen.create(context)
    );
  }
}