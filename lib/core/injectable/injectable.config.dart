// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/auth/data/repositories/auth_repository.dart' as _i6;
import '../../features/auth/data/repositories/firebase_auth_repository.dart'
    as _i7;
import '../../features/email_base_auth/presentation/cubit/continue_with_email_cubit.dart'
    as _i8;
import '../../features/start/presentation/cubit/start_cubit.dart' as _i4;
import '../validators/text/text_validators.dart' as _i5;
import 'modules/firebase_auth_module.dart' as _i9;

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
    gh.factory<_i3.FirebaseAuth>(() => firebaseAuthModule.firebaseAuth);
    gh.factory<_i4.StartCubit>(() => _i4.StartCubit());
    gh.factory<_i5.TextValidator>(() => _i5.TextValidator());
    gh.factory<_i6.AuthRepository>(
        () => _i7.FirebaseAuthRepository(gh<_i3.FirebaseAuth>()));
    gh.factory<_i8.ContinueWithEmailCubit>(() => _i8.ContinueWithEmailCubit(
          gh<_i5.TextValidator>(),
          gh<_i6.AuthRepository>(),
        ));
    return this;
  }
}

class _$FirebaseAuthModule extends _i9.FirebaseAuthModule {}
