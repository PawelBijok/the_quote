import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/collection/domain/repositories/collection_repository.dart';
import 'package:the_quote/shared/domain/failures/failure.dart';

@Injectable(as: CollectionRepository)
class CollectionRepositoryImpl implements CollectionRepository {
  CollectionRepositoryImpl(this.firebaseAuth, this.firebaseFirestore);

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  @override
  Future<Either<Failure, void>> addNewCollection(CollectionModel collection) async {
    try {
      final collections = firebaseFirestore.collection('users').doc(uID).collection('collections');

      final newCollection = await collections.add(collection.toJson());
      await newCollection.update({'id': newCollection.id});

      return const Right(null);
    } catch (e, st) {
      return Left(UnknownFailure(e.toString(), st));
    }
  }

  @override
  Stream<CollectionModel> collectionStream(String id) {
    return firebaseFirestore.collection('users').doc(uID).collection('collections').doc(id).snapshots().map(
          (event) => CollectionModel.fromJson(event.data()!),
        );
  }

  @override
  Stream<List<CollectionModel>> collectionsStream() {
    return firebaseFirestore.collection('users').doc(uID).collection('collections').snapshots().map(
          (event) => event.docs.map(
            (e) {
              return CollectionModel.fromJson(
                e.data(),
              );
            },
          ).toList(),
        );
  }

  @override
  Future<Either<Failure, void>> editExistingCollection(CollectionModel collection) async {
    try {
      final collectionDoc = firebaseFirestore.collection('users').doc(uID).collection('collections').doc(collection.id);
      await collectionDoc.update(collection.toJson());

      return const Right(null);
    } catch (e, st) {
      return Left(UnknownFailure(e.toString(), st));
    }
  }

  String? get uID {
    return firebaseAuth.currentUser?.uid;
  }

  @override
  Future<Either<Failure, void>> deleteCollection(String id) async {
    try {
      await firebaseFirestore.collection('users').doc(uID).collection('collections').doc(id).delete();
      return const Right(null);
    } on SocketException catch (e, st) {
      return Left(NoInternetFailure(e.toString(), st));
    } catch (e, st) {
      return Left(UnknownFailure(e.toString(), st));
    }
  }
}
