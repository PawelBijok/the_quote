import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/src/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/features/quote/domain/repositories/quote_repository.dart';
import 'package:the_quote/shared/domain/failures/failure.dart';

@Injectable(as: QuoteRepository)
class QuoteRepositoryImpl implements QuoteRepository {
  QuoteRepositoryImpl(this.firebaseAuth, this.firebaseFirestore);

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  @override
  Future<Either<Failure, void>> addNewQuote(String collection, QuoteModel quote) {
    // TODO: implement addNewQuote
    throw UnimplementedError();
  }

  @override
  Stream<QuoteModel> quoteStream(String collectionId, String id) {
    // TODO: implement quoteStream
    throw UnimplementedError();
  }

  @override
  Stream<List<QuoteModel>> quotesStream(String collectionId) {
    return firebaseFirestore
        .collection('users')
        .doc(uID)
        .collection('collections')
        .doc(collectionId)
        .collection('quotes')
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
}
