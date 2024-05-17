import 'package:firebase_storage/firebase_storage.dart';

class MeteoFirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> getImagesFromFolder(String folderName) async {
    List<String> imageUrls = [];
    try {
      ListResult result = await _storage.ref().child(folderName).listAll();
      // ignore: avoid_function_literals_in_foreach_calls
      result.items.forEach((Reference ref) async {
        String url = await ref.getDownloadURL();
        imageUrls.add(url);
      });
    } catch (e) {
      print('Error fetching images: $e');
    }
    return imageUrls;
  }
}
