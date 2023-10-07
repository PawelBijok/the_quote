import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/collection/domain/repositories/collection_repository.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/features/quote/domain/repositories/quote_repository.dart';

part 'collection_cubit.freezed.dart';
part 'collection_state.dart';

@injectable
class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit(this.collectionRepository, this.quoteRepository) : super(const CollectionState.initial());

  final CollectionRepository collectionRepository;
  final QuoteRepository quoteRepository;

  final List<StreamSubscription> subs = [];
  late final String collectionId;

  Future<void> init(String collectionId, CollectionModel? preloadedCollection) async {
    this.collectionId = collectionId;
    if (preloadedCollection != null) {
      emit(CollectionState.loaded(collection: preloadedCollection));
    }
    final quotesStream = quoteRepository.quotesStream(collectionId);
    final collectionStream = collectionRepository.collectionStream(collectionId);
    final sub = Rx.combineLatest2(
      quotesStream,
      collectionStream,
      (q, c) => (q, c),
    ).listen(
      (event) {
        final (quotes, collection) = event;
        emit(CollectionState.loaded(collection: collection, quotes: quotes));
      },
    );

    subs.add(sub);
  }

  Future<void> deleteQuote(String quoteId) async {
    await quoteRepository.deleteQuote(collectionId, quoteId);
  }

  @override
  Future<void> close() {
    for (final sub in subs) {
      sub.cancel();
    }
    return super.close();
  }
}
