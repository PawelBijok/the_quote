import 'dart:typed_data';

import 'package:either_dart/either.dart';
import 'package:the_quote/shared/domain/failures/failure.dart';

abstract class RemoteStorageRepository {
  Future<Either<Failure, String>> uploadFile({
    required Uint8List file,
    required String filename,
  });
}
