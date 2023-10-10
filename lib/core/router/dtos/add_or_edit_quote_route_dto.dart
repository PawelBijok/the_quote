import 'package:the_quote/features/quote/domain/models/quote_model.dart';

class AddOrEditQuoteRouteDto {
  const AddOrEditQuoteRouteDto({
    required this.collectionId,
    this.quoteToEdit,
  });
  final QuoteModel? quoteToEdit;
  final String collectionId;
}
