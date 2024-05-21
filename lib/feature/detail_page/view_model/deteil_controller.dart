import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final detailNotifier = ChangeNotifierProvider((ref) => DetailController());

class DetailController with ChangeNotifier {
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
