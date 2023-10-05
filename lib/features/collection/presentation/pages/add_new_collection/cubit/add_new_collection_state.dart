part of 'add_new_collection_cubit.dart';

@freezed
class AddNewCollectionState with _$AddNewCollectionState {
  const factory AddNewCollectionState.initial({
    @Default('') String collectionTitle,
    String? collectionDescription,
    String? imageUrl,
    @Default(false) bool isLoading,
  }) = _Initial;

  const factory AddNewCollectionState.success() = _Loading;
}
