import 'package:aviatoruz/data/entity/english_model.dart';
import 'package:aviatoruz/data/repository/app_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final englishTopicProvider =
    ChangeNotifierProvider((ref) => EnglishTopicNotifier());

class EnglishTopicNotifier extends ChangeNotifier {
  bool isLoading = false;

  EnglishModel? englishModel;
  Future<void> getEnglishInifo() async {
    isLoading = true;
    final result = await AppRepositoryImpl().getEnglish();
    if (result != null) {
      englishModel = result;
      isLoading = false;
    } else {
      englishModel = null;
    }
    notifyListeners();
  }

  double scale = 1.0;

  void zoomIn() {
    scale += 0.1;
    notifyListeners();
  }

  void zoomOut() {
    if (scale > 0.1) scale -= 0.1;
    notifyListeners();
  }
}
