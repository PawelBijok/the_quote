import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseFirestoreModule {
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
}
