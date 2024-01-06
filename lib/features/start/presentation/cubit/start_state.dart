part of 'start_cubit.dart';

@freezed
class StartState with _$StartState {
  const factory StartState({
    @Default(false) bool loading,
    AuthFailure? failure,
    UserModel? signedInUser,
  }) = _StartState;
}
