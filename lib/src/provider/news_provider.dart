import 'dart:convert';
import 'package:app_notice_bloc_flutter/src/model/api_response.dart';
import 'package:app_notice_bloc_flutter/src/model/article.dart';
import 'package:http/http.dart' as http;


class MissingApiKeyException implements Exception{}
class ApiKeyInvalidException implements Exception{}

class NewsProvider{

  static String _apiKey = "c174557b050f4ef3bd6aa93a8a6cf877";
  static String _baseUrl = "newsapi.org";
  static String _topHeadLines = "v2/top-headlines";

  final http.Client _httpClient;

  NewsProvider({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  Future<List<Article>> topHeadLines(String country) async{
    final result = await _callGetAPi(
        endpoint: _topHeadLines, 
        params: {
          "country": country,
          "apiKey": _apiKey,
      }
    );
    return result.articles;
  }

  Future<ApiResponse> _callGetAPi({
    required String endpoint,
    required Map<String, String> params,
  })async{
    var uri = Uri.https(_baseUrl, endpoint, params);

    final response = await _httpClient.get(uri);
    final result = ApiResponse.fromJson(json.decode(response.body));

    if (result.status == "error"){
      if(result.code == "apiKeyMissing") throw MissingApiKeyException();
      if(result.code == "apiKeyInvalid") throw ApiKeyInvalidException();
      throw  Exception();
    }
    return result;
  }

}

