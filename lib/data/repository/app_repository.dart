import 'package:aviatoruz/data/entity/english_model.dart';
import 'package:aviatoruz/data/entity/meteo_model.dart';
import 'package:aviatoruz/data/entity/news_model.dart';
import 'package:aviatoruz/data/entity/sections_model.dart';

abstract class AppRepository {
  Future<String?> example({required String id, required String status});

  /// Get API
  Future<MeteoModel?> getMeteo(String api);

  Future<EnglishModel?> getEnglish();
  Future<NewsModel?> getNews();
  Future<SectionModel?> getSections();
}
