part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default('') String prompt,
    @Default([]) List<QuoteModel> quotes,
    @Default(SearchStatus.loading) SearchStatus status,
  }) = _SearchState;
}

enum SearchStatus { loading, loaded, failure }
