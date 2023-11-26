import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:the_quote/core/utils/converters/timestamp_to_date_time_converter.dart';
import 'package:the_quote/features/tags/domain/models/tag_model.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@freezed
class QuoteModel with _$QuoteModel {
  const factory QuoteModel({
    required String id,
    required String collectionId,
    required String content,
    @TimestampToDateTimeConverter() required DateTime createdAt,
    @Default([]) List<TagModel> tags,
  }) = _QuoteModel;

  factory QuoteModel.fromJson(Map<String, dynamic> json) => _$QuoteModelFromJson(json);
}
