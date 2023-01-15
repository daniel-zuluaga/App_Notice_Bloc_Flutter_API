import 'package:app_notice_bloc_flutter/src/bloc/news_cubit.dart';
import 'package:app_notice_bloc_flutter/src/model/article.dart';
import 'package:app_notice_bloc_flutter/src/navigation/routes.dart';
import 'package:app_notice_bloc_flutter/src/repository/news_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  static Widget create(BuildContext context){
    return BlocProvider<NewsCubit>(
      create: (_) {
        final repository = context.read<NewsRepositoryBase>();
        return NewsCubit(repository)..loadTopNews();
      },
      child: const NewsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Top of News Notice"),
        ),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if(state is NewsLoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(state is NewsErrorState){
              return Text(state.message);
            }

            final news = (state as NewsLoadCompletedState).news;

            return ListView.builder(
              itemCount: news.length,
              itemBuilder: (_, int index){
                return _ListItem(article: news[index]);
            });
          },
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final Article article;

  const _ListItem({
    required this.article
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, Routes.topNewsDetails, arguments: article);
      },
      child: Card(
         child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
    
            article.urlToImage == null ? Container(
              color: Colors.green,
              height: 250,
            ) : Image.network(article.urlToImage!),
    
    
            const SizedBox(
              height: 12,
            ),
    
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                article.title,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
    
            const SizedBox(
              height: 10,
            ),
    
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                article.description!,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
    
            const SizedBox(
              height: 20,
            ),
          ],
         ),
      ),
    );
  }
}