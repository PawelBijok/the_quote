part of 'add_or_edit_quote_cubit.dart';

@freezed
class AddOrEditQuoteState with _$AddOrEditQuoteState {
  const factory AddOrEditQuoteState({
    @Default(false) bool isEditing,
    @Default('autoId') String collectionId,
    @Default('autoId') String quoteId,
    @Default('') String content,
    DateTime? createdAt,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
  }) = _AddOrEditQuoteState;
}
