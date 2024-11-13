import 'package:aviatoruz/core/services/network_service.dart';
import 'package:aviatoruz/data/entity/english_model.dart';
import 'package:aviatoruz/data/entity/meteo_model.dart';
import 'package:aviatoruz/data/entity/news_model.dart';
import 'package:flutter/material.dart';

import 'app_repository.dart';

@immutable
final class AppRepositoryImpl implements AppRepository {
  static const AppRepositoryImpl _impl = AppRepositoryImpl._internal();

  const AppRepositoryImpl._internal();

  factory AppRepositoryImpl() => _impl;

  @override
  Future<String?> example({required String id, required String status}) {
    throw UnimplementedError();
  }

  @override
  Future<MeteoModel?> getMeteo() async {
    final result = await ClientService.get(
      api: ClientService.apiGetMeteo,
    );
    if (result != null) {
      return meteoModelFromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<EnglishModel?> getEnglish() async {
    final result = await ClientService.get(
      api: ClientService.apiGetEnglish,
    );
    if (result != null) {
      return englishModelFromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<NewsModel?> getNews() async {
    final result = await ClientService.get(
      api: ClientService.apiGetNews,
    );
    if (result != null) {
      return newsModelFromJson(result);
    } else {
      return null;
    }
  }
}
