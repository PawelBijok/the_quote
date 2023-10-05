import 'package:either_dart/either.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/shared/domain/failures/failure.dart';

abstract class RemoteDataRepository {
  Stream<List<CollectionModel>> getCollections();
  Stream<CollectionModel> getCollection({required String id});
  Future<Either<Failure, void>> addCollection(CollectionModel collection);
}
