import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/features/quote/domain/repositories/quote_repository.dart';

part 'add_or_edit_quote_cubit.freezed.dart';
part 'add_or_edit_quote_state.dart';

@injectable
class AddOrEditQuoteCubit extends Cubit<AddOrEditQuoteState> {
  AddOrEditQuoteCubit(this.quoteRepository) : super(const AddOrEditQuoteState());

  final QuoteRepository quoteRepository;

  Future<void> init({required String collectionId, QuoteModel? quoteToEdit}) async {
    if (quoteToEdit != null) {
      return emit(
        AddOrEditQuoteState(
          collectionId: collectionId,
          quoteId: quoteToEdit.id,
          content: quoteToEdit.content,
          createdAt: quoteToEdit.createdAt,
          isEditing: true,
        ),
      );
    }
  }

  void onContentChanged(String? content) {
    if (content == null) {
      return;
    }

    emit(state.copyWith(content: content));
  }

  void save() {}
}
