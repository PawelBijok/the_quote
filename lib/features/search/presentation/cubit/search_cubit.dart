import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/core/validators/text/text_validation_option.dart';
import 'package:the_quote/core/validators/text/text_validators.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/features/quote/domain/repositories/quote_repository.dart';

part 'search_cubit.freezed.dart';
part 'search_state.dart';

@injectable
class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._textValidator, this._quoteRepository) : super(const SearchState());
  final QuoteRepository _quoteRepository;
  final TextValidator _textValidator;

  List<QuoteModel>? _quotes;

  Future<void> init() async {
    await _getNewQuotes(state.prompt);
  }

  Future<void> _getNewQuotes(String? prompt) async {
    emit(state.copyWith(status: SearchStatus.loading));
    final quotesOrFailure = await _quoteRepository.getQuotes(state.prompt);
    quotesOrFailure.fold((left) => emit(state.copyWith(status: SearchStatus.failure)), _onQuotesChanged);
  }

  void _onQuotesChanged(List<QuoteModel> quotes) {
    emit(state.copyWith(status: SearchStatus.loaded, quotes: quotes));
    _quotes = quotes;
  }

  void onPromptChanged(String? prompt) {
    final textValidation = _textValidator(NotEmptyTextValidation(prompt));
    if (textValidation != null) {
      if (_quotes == null) {
        return;
      }
      return emit(state.copyWith(quotes: _quotes!));
    }
    emit(state.copyWith(prompt: prompt!));
    if (state.status != SearchStatus.loaded || _quotes == null) {
      return;
    }
    emit(state.copyWith(quotes: _quotes!.where((element) => element.content.contains(prompt)).toList()));
  }

  Future<void> deleteQuote({required String quoteId, required String parentCollectionId}) async {
    await _quoteRepository.deleteQuote(parentCollectionId, quoteId);
    emit(state.copyWith(quotes: state.quotes.where((quote) => quote.id != quoteId).toList()));
    _quotes = _quotes?.where((quote) => quote.id != quoteId).toList();
  }
}
