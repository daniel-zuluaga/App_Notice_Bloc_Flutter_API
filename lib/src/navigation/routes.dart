
import 'package:app_notice_bloc_flutter/src/ui/news_screen.dart';
import 'package:app_notice_bloc_flutter/src/ui/news_screen_details.dart';
import 'package:flutter/material.dart';

class Routes{

  static const topNews = "home_news_notice";
  static const topNewsDetails = "details";

  static Route routes (RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name) {
      case topNews:
        return MaterialPageRoute(builder: (context) => 
            NewsScreen.create(context));

      case topNewsDetails:
        return MaterialPageRoute(builder: (context) => 
            NewsScreenDetails.create(args!));
      
      default:
        return MaterialPageRoute(builder: (context) => 
            NewsScreen.create(context));
    }
  }

}
