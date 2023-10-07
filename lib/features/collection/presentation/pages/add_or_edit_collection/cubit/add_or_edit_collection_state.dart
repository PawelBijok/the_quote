part of 'add_or_edit_collection_cubit.dart';

@freezed
class AddOrEditCollectionState with _$AddOrEditCollectionState {
  const factory AddOrEditCollectionState.initial({
    @Default(false) bool isEditing,
    @Default('autoId') String collectionId,
    @Default('') String collectionTitle,
    String? collectionDescription,
    String? imageUrl,
    @Default(false) bool isLoading,
  }) = _Initial;

  const factory AddOrEditCollectionState.success() = _Loading;
}
