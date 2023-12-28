part of 'add_or_edit_quote_cubit.dart';

@freezed
class AddOrEditQuoteState with _$AddOrEditQuoteState {
  const factory AddOrEditQuoteState({
    @Default(false) bool isEditing,
    @Default('autoId') String collectionId,
    @Default('autoId') String quoteId,
    @Default('') String content,
    @Default('quote_content_key') String refreshInputKey,
    DateTime? createdAt,
    @Default(false) bool showErrors,
    TextValidationError? quoteValidation,
    @Default(AddOrEditQuoteStatus.initial) AddOrEditQuoteStatus status,
    QuoteFromPhotoProposals? quoteProposals,
  }) = _AddOrEditQuoteState;
}

enum AddOrEditQuoteStatus { initial, loading, success, failure }

@freezed
class QuoteFromPhotoProposals with _$QuoteFromPhotoProposals {
  const factory QuoteFromPhotoProposals({
    required String plainText,
    required List<UniqueIdText> lines,
    required List<UniqueIdText> blocks,
    @Default([]) List<UniqueIdText> selectedText,
  }) = _QuoteFromPhotoProposals;

  factory QuoteFromPhotoProposals.test() => const _QuoteFromPhotoProposals(
          plainText: 'To jest testowy tekst'
              'To jest testowy testk To był testowy tekst To będzie testowy tekst To jest testowy testk To był testowy tekst To będzie testowy tekst',
          lines: [
            UniqueIdText(
              id: 1,
              text: 'To jest testowy testk',
            ),
            UniqueIdText(
              id: 2,
              text: 'To był testowy tekst',
            ),
            UniqueIdText(id: 3, text: 'To będzie testowy tekst'),
          ],
          blocks: [
            UniqueIdText(
              id: 5,
              text: 'To jest testowy testk To był testowy tekst To będzie testowy tekst',
            ),
            UniqueIdText(id: 4, text: 'To jest testowy testk To był testowy tekst To będzie testowy tekst'),
          ]);
}

@freezed
class UniqueIdText with _$UniqueIdText {
  const factory UniqueIdText({
    required int id,
    required String text,
  }) = _UniqueIdText;
}
