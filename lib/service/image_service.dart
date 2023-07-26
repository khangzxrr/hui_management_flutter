import 'package:firebase_storage/firebase_storage.dart';

class ImageService {
  Future<String> getImagePathFromFireStorage(String imageUrl) async {
    final firebaseStorage = FirebaseStorage.instanceFor(bucket: 'gs://test-1d90e.appspot.com').ref('public');

    final imageRef = firebaseStorage.child(imageUrl);

    return await imageRef.getDownloadURL();
  }
}
