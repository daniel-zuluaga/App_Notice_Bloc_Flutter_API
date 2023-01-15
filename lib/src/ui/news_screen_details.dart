import 'package:app_notice_bloc_flutter/src/model/article.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsScreenDetails extends StatelessWidget {

  static Widget create(Object article) => 
    NewsScreenDetails(article: article as Article);


  final Article article;

  const NewsScreenDetails({
    super.key, 
    required this.article
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notice News with details"),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
    
            article.urlToImage == null ? Container(
              color: Colors.green,
              height: 250,
            ) : Image.network(article.urlToImage!),
    
    
            const SizedBox(
              height: 20,
            ),
    
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                article.title,
                style: const TextStyle(
                  fontSize: 22,
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
                article.description?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            ElevatedButton(
              onPressed: (){
                // launch(article.url!);
                launchUrlString(article.url!);
              }, 
              child: const Text("More details")
            ),
          ],
        ),
      ),
    );
  }
}