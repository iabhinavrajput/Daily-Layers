import 'dart:convert';
import 'package:daily_layer/models/categories_news_model.dart';
import 'package:daily_layer/models/news_channel_headline_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadLinesApi(
      String newsName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=${newsName}&apiKey=a95ea4d7ea8d4aa19d114561cdccaff2';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }


    Future<CategoriesNewsModel> fetchNewsCategoriesNewsApi(
      String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=a95ea4d7ea8d4aa19d114561cdccaff2';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
