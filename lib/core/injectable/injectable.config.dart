// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_storage/firebase_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/auth/data/repositories/firebase_auth_repository.dart'
    as _i15;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i14;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i23;
import '../../features/collection/domain/data/repositories/collection_repository_impl.dart'
    as _i17;
import '../../features/collection/domain/repositories/collection_repository.dart'
    as _i16;
import '../../features/collection/presentation/pages/add_or_edit_collection/cubit/add_or_edit_collection_cubit.dart'
    as _i22;
import '../../features/collection/presentation/pages/collection/cubit/collection_cubit.dart'
    as _i24;
import '../../features/email_base_auth/presentation/cubit/continue_with_email_cubit.dart'
    as _i18;
import '../../features/home/presentation/page/cubit/home_cubit.dart' as _i19;
import '../../features/quote/data/repositories/quote_repository_impl.dart'
    as _i8;
import '../../features/quote/domain/repositories/quote_repository.dart' as _i7;
import '../../features/quote/presentation/cubit/add_or_edit_quote_cubit.dart'
    as _i13;
import '../../features/reset_password/presentation/cubit/reset_password_cubit.dart'
    as _i21;
import '../../features/start/presentation/cubit/start_cubit.dart' as _i11;
import '../../shared/application/image_picker_and_uploader/image_picker_and_uploader_cubit.dart'
    as _i20;
import '../../shared/data/repositories/firebase_remote_storage_repository.dart'
    as _i10;
import '../../shared/domain/repositories/remote_storage_repository.dart' as _i9;
import '../validators/text/text_validators.dart' as _i12;
import 'modules/firebase_auth_module.dart' as _i27;
import 'modules/firebase_firestore_module.dart' as _i25;
import 'modules/firebase_storage_module.dart' as _i26;
import 'modules/image_picker_module.dart' as _i28;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseAuthModule = _$FirebaseAuthModule();
    final firebaseFirestoreModule = _$FirebaseFirestoreModule();
    final firebaseStorageModule = _$FirebaseStorageModule();
    final imagePickerModule = _$ImagePickerModule();
    gh.factory<_i3.FirebaseAuth>(() => firebaseAuthModule.firebaseAuth);
    gh.factory<_i4.FirebaseFirestore>(
        () => firebaseFirestoreModule.firebaseFirestore);
    gh.factory<_i5.FirebaseStorage>(
        () => firebaseStorageModule.firebaseStorage);
    gh.factory<_i6.ImagePicker>(() => imagePickerModule.imagePicker);
    gh.factory<_i7.QuoteRepository>(() => _i8.QuoteRepositoryImpl(
          gh<_i3.FirebaseAuth>(),
          gh<_i4.FirebaseFirestore>(),
        ));
    gh.factory<_i9.RemoteStorageRepository>(
        () => _i10.FirebaseRemoteStorageRepository(gh<_i5.FirebaseStorage>()));
    gh.factory<_i11.StartCubit>(() => _i11.StartCubit());
    gh.factory<_i12.TextValidator>(() => _i12.TextValidator());
    gh.factory<_i13.AddOrEditQuoteCubit>(() => _i13.AddOrEditQuoteCubit(
          gh<_i7.QuoteRepository>(),
          gh<_i12.TextValidator>(),
        ));
    gh.factory<_i14.AuthRepository>(
        () => _i15.FirebaseAuthRepository(gh<_i3.FirebaseAuth>()));
    gh.factory<_i16.CollectionRepository>(() => _i17.CollectionRepositoryImpl(
          gh<_i3.FirebaseAuth>(),
          gh<_i4.FirebaseFirestore>(),
        ));
    gh.factory<_i18.ContinueWithEmailCubit>(() => _i18.ContinueWithEmailCubit(
          gh<_i12.TextValidator>(),
          gh<_i14.AuthRepository>(),
        ));
    gh.factory<_i19.HomeCubit>(
        () => _i19.HomeCubit(gh<_i16.CollectionRepository>()));
    gh.factory<_i20.ImagePickerAndUploaderCubit>(
        () => _i20.ImagePickerAndUploaderCubit(
              gh<_i6.ImagePicker>(),
              gh<_i9.RemoteStorageRepository>(),
            ));
    gh.factory<_i21.ResetPasswordCubit>(() => _i21.ResetPasswordCubit(
          gh<_i12.TextValidator>(),
          gh<_i14.AuthRepository>(),
        ));
    gh.factory<_i22.AddOrEditCollectionCubit>(
        () => _i22.AddOrEditCollectionCubit(gh<_i16.CollectionRepository>()));
    gh.lazySingleton<_i23.AuthCubit>(
        () => _i23.AuthCubit(gh<_i14.AuthRepository>()));
    gh.factory<_i24.CollectionCubit>(() => _i24.CollectionCubit(
          gh<_i16.CollectionRepository>(),
          gh<_i7.QuoteRepository>(),
        ));
    return this;
  }
}

class _$FirebaseFirestoreModule extends _i25.FirebaseFirestoreModule {}

class _$FirebaseStorageModule extends _i26.FirebaseStorageModule {}

class _$FirebaseAuthModule extends _i27.FirebaseAuthModule {}

class _$ImagePickerModule extends _i28.ImagePickerModule {}
