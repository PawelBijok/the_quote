part of 'collection_cubit.dart';

@freezed
class CollectionState with _$CollectionState {
  const factory CollectionState.initial() = _Initial;
  const factory CollectionState.loaded({
    required CollectionModel collection,
    @Default([]) List<QuoteModel> quotes,
  }) = _Loaded;
}
