import 'dart:convert';

import 'package:app_notice_bloc_flutter/src/model/api_response.dart';
import 'package:http/http.dart' as http;

class NewsProvider{

  static String _apiKey = "xxxxxx";
  static String _baseUrl = "newsapi.org";
  static String _topHeadLines = "v2/everything";

  final http.Client _httpClient;

  NewsProvider({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  Future<ApiResponse> _callGetAPi({
    required String endpoint,
    required Map<String, String> params,
  })async{
    var uri = Uri.https(_baseUrl, endpoint, params);

    final response = await _httpClient.get(uri);
    final result = ApiResponse.fromJson(json.decode(response.body));

    if (result.status == "error"){
      throw  Exception();
    }
    return result;
  }

}
