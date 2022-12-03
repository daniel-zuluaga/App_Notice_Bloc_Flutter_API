import 'dart:io';

import 'package:app_notice_bloc_flutter/src/provider/news_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test("Top headLines is correct", () async{
    final provider = _getProvider("test/provider_test/top_headlines.json");
    final articles = await provider.topHeadLines("US");

    expect(articles.length, 20);
    expect(articles[0].author, "Samantha Subin"); 
    expect(articles[1].author, "Investor's Business Daily"); 

  });

    test("ApiKey missing exception", () async{
      final provider = _getProvider("test/provider_test/api_key_missing.json");

      expect(provider.topHeadLines("US"), throwsA(predicate((exception) => exception is MissingApiKeyException)));

    });

    test("ApiKey Invalid exception", () async{
      final provider = _getProvider("test/provider_test/api_key_invalid.json");

      expect(provider.topHeadLines("US"), throwsA(predicate((exception) => exception is ApiKeyInvalidException)));

    });

 
}

 NewsProvider _getProvider(String filePath) => NewsProvider(httpClient: _getMockProvider(filePath));

  MockClient _getMockProvider(String filePath) => MockClient((_) async => 
    Response(await File(filePath).readAsString(), 200, headers: {
      HttpHeaders.contentTypeHeader: "application/jason; charset=utf-8"
    }));