import 'package:either_dart/either.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/shared/domain/failures/failure.dart';

abstract class CollectionRepository {
  Stream<List<CollectionModel>> collectionsStream();
  Stream<CollectionModel> collectionStream(String id);
  Future<Either<Failure, void>> addNewCollection(CollectionModel collection);
}
