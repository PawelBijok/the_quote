import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseStorageModule {
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;
}
