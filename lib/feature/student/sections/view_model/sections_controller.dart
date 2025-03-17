import 'package:aviatoruz/data/entity/sections_model.dart';
import 'package:aviatoruz/data/repository/app_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sectionsProvider = ChangeNotifierProvider((ref) => SectionsController());

class SectionsController with ChangeNotifier {
  bool isLoading = false;

  SectionModel? meteoModel;
  Future<void> getSectionsInfo() async {
    isLoading = true;
    final result = await AppRepositoryImpl().getSections();
    if (result != null) {
      meteoModel = result;
      isLoading = false;
    } else {
      meteoModel = null;
    }
    notifyListeners();
  }
}
