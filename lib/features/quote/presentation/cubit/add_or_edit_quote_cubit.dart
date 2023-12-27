import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/core/validators/text/text_validation_error.dart';
import 'package:the_quote/core/validators/text/text_validation_option.dart';
import 'package:the_quote/core/validators/text/text_validators.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/features/quote/domain/repositories/quote_repository.dart';
import 'package:the_quote/shared/domain/failures/failure.dart';

part 'add_or_edit_quote_cubit.freezed.dart';
part 'add_or_edit_quote_state.dart';

@injectable
class AddOrEditQuoteCubit extends Cubit<AddOrEditQuoteState> {
  AddOrEditQuoteCubit(this._quoteRepository, this._textValidator) : super(const AddOrEditQuoteState());

  final QuoteRepository _quoteRepository;
  final TextValidator _textValidator;

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
    emit(
      state.copyWith(
        collectionId: collectionId,
      ),
    );
  }

  Future<void> getFromImage() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final file = image.path;
    final inputImage = InputImage.fromFilePath(file);
    final textRecognizer = TextRecognizer();
    final recognizedText = await textRecognizer.processImage(inputImage);

    final text = recognizedText.text;
    for (TextBlock block in recognizedText.blocks) {
      final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      print('block: ${block.text}');
      for (final line in block.lines) {
        // Same getters as TextBlock
        print('line: ${line.text}');
        for (final element in line.elements) {
          // Same getters as TextBlock
          print('element: ${element.text}');
        }
      }
      // print(text);
    }
    await textRecognizer.close();
  }

  void onContentChanged(String? content) {
    if (content == null) {
      return;
    }
    final quoteValidation = _textValidator(NotEmptyTextValidation(content));
    emit(
      state.copyWith(
        content: content,
        quoteValidation: quoteValidation,
      ),
    );
  }

  Future<void> save() async {
    final quoteValidation = _textValidator(NotEmptyTextValidation(state.content));
    if (quoteValidation != null) {
      return emit(
        state.copyWith(
          quoteValidation: quoteValidation,
          showErrors: true,
        ),
      );
    }
    emit(state.copyWith(status: AddOrEditQuoteStatus.loading));
    final quote = QuoteModel(
      id: state.quoteId,
      content: state.content,
      createdAt: state.isEditing ? state.createdAt! : DateTime.now(),
      collectionId: state.collectionId,
    );
    late final Either<Failure, void> failureOrNull;
    if (state.isEditing) {
      failureOrNull = await _quoteRepository.updateQuote(state.collectionId, quote);
    } else {
      failureOrNull = await _quoteRepository.addNewQuote(state.collectionId, quote);
    }
    failureOrNull.fold((left) {
      emit(state.copyWith(status: AddOrEditQuoteStatus.failure));
      print('failure: $left');
    }, (right) {
      emit(state.copyWith(status: AddOrEditQuoteStatus.success));
    });
  }
}
