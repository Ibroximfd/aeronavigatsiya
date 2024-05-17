import 'package:aviatoruz/core/constant/network_service_const.dart';
import 'package:aviatoruz/core/services/firebase_store_service/meteo_topic_store_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageServiceProvider =
    Provider<MeteoFirebaseStorageService>((ref) {
  return MeteoFirebaseStorageService();
});

final imageUrlsProvider = FutureProvider<List<String>>((ref) async {
  final storageService = ref.watch(firebaseStorageServiceProvider);
  return storageService
      .getImagesFromFolder(NetworkServiceConst.meteoTopicsImage);
});
