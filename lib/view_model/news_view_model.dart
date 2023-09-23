import 'package:daily_layer/models/categories_news_model.dart';
import 'package:daily_layer/models/news_channel_headline_model.dart';
import 'package:daily_layer/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadLinesApi(String newsName) async {
    final response = await _repo.fetchNewsChannelHeadLinesApi(newsName);
    return response;
  }

    Future<CategoriesNewsModel> fetchNewsCategoriesNewsApi(String category) async {
    final response = await _repo.fetchNewsCategoriesNewsApi(category);
    return response;
  }
}
