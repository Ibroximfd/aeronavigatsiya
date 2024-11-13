import 'package:aviatoruz/data/entity/english_model.dart';
import 'package:aviatoruz/data/entity/meteo_model.dart';
import 'package:aviatoruz/data/entity/news_model.dart';

abstract class AppRepository {
  Future<String?> example({required String id, required String status});

  /// Get API
  Future<MeteoModel?> getMeteo();

  Future<EnglishModel?> getEnglish();
  Future<NewsModel?> getNews();
}
