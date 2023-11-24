import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/features/quote/domain/repositories/quote_repository.dart';
import 'package:the_quote/shared/domain/failures/failure.dart';

@Injectable(as: QuoteRepository)
class QuoteRepositoryImpl implements QuoteRepository {
  QuoteRepositoryImpl(this.firebaseAuth, this.firebaseFirestore);

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  @override
  Future<Either<Failure, void>> addNewQuote(String collection, QuoteModel quote) async {
    try {
      final docRef = await firebaseFirestore.collection('users').doc(uID).collection('quotes').add(quote.toJson());
      await docRef.update({'collectionId': collection, 'id': docRef.id});
      await _updateQuotesQuantity(collectionId: collection, isDeletion: false);
      return const Right(null);
    } on SocketException catch (e, st) {
      return Left(NoInternetFailure(e.toString(), st));
    }
  }

  @override
  Stream<QuoteModel> quoteStream(String id) {
    // TODO(pafello): implement quoteStream
    throw UnimplementedError();
  }

  @override
  Stream<List<QuoteModel>> collectionQuotesStream(String collectionId) {
    return firebaseFirestore
        .collection('users')
        .doc(uID)
        .collection('quotes')
        .where('collectionId', isEqualTo: collectionId)
        .snapshots()
        .map(
          (event) => event.docs.map(
            (e) {
              return QuoteModel.fromJson(
                e.data(),
              );
            },
          ).toList(),
        );
  }

  String? get uID {
    return firebaseAuth.currentUser?.uid;
  }

  @override
  Future<Either<Failure, void>> deleteQuote(String collectionId, String quoteId) async {
    try {
      final ref = firebaseFirestore.collection('users').doc(uID).collection('quotes').doc(quoteId);
      await _updateQuotesQuantity(collectionId: collectionId, isDeletion: true);
      await ref.delete();

      return const Right(null);
    } catch (e, st) {
      return Left(UnknownFailure(e.toString(), st));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuote(String collection, QuoteModel quote) async {
    try {
      await firebaseFirestore.collection('users').doc(uID).collection('quotes').doc(quote.id).update(quote.toJson());
      return const Right(null);
    } on SocketException catch (e, st) {
      return Left(NoInternetFailure(e.toString(), st));
    } catch (e, st) {
      return Left(UnknownFailure(e.toString(), st));
    }
  }

  Future<void> _updateQuotesQuantity({required String collectionId, required bool isDeletion}) async {
    const quotesQuantityKey = 'quotesQuantity';
    final userRef = firebaseFirestore.collection('users').doc(uID);
    final allQuotesQuantity = int.parse((await userRef.get()).data()?[quotesQuantityKey].toString() ?? '0');
    final newAllQuotesQuantity = allQuotesQuantity + (isDeletion ? -1 : 1);
    await userRef.update({quotesQuantityKey: newAllQuotesQuantity});
    final collectionRef = firebaseFirestore.collection('users').doc(uID).collection('collections').doc(collectionId);
    final collectionModel = CollectionModel.fromJson((await collectionRef.get()).data() ?? {});
    final newCollectionQuoteQuantity = collectionModel.quotesQuantity + (isDeletion ? -1 : 1);
    await collectionRef.update({'quotesQuantity': newCollectionQuoteQuantity});
  }

  @override
  Stream<int> quotesQuantityStream() {
    return firebaseFirestore
        .collection('users')
        .doc(uID)
        .snapshots()
        .map((event) => int.parse(event.data()?['quotesQuantity'].toString() ?? '0'));
  }
}
