import 'package:either_dart/either.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/shared/domain/failures/failure.dart';

abstract class QuoteRepository {
  Stream<List<QuoteModel>> collectionQuotesStream(String collectionId);
  Stream<QuoteModel> quoteStream(String id);
  Future<Either<Failure, void>> addNewQuote(String collection, QuoteModel quote);
  Future<Either<Failure, void>> updateQuote(String collection, QuoteModel quote);
  Future<Either<Failure, void>> deleteQuote(String collectionId, String quoteId);
}
