import 'dart:typed_data';

import 'package:either_dart/src/either.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/shared/domain/failures/failure.dart';
import 'package:the_quote/shared/domain/repositories/remote_storage_repository.dart';

@Injectable(as: RemoteStorageRepository)
class FirebaseRemoteStorageRepository implements RemoteStorageRepository {
  FirebaseRemoteStorageRepository(this.firebaseStorage);

  final FirebaseStorage firebaseStorage;

  @override
  Future<Either<Failure, String>> uploadFile({
    required Uint8List file,
    required String filename,
  }) async {
    try {
      final ref = await firebaseStorage.ref('/uploads/${filename}');
      final uploadTask = ref.putData(file);
      final downloadUrl = await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
      return Right(downloadUrl);
    } catch (e, st) {
      return Left(UnknownFailure(e.toString(), st));
    }
  }
}
