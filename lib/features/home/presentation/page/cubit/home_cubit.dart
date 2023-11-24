import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/collection/domain/repositories/collection_repository.dart';
import 'package:the_quote/features/quote/domain/repositories/quote_repository.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._collectionRepository, this._quoteRepository) : super(const HomeState.initial());
  final CollectionRepository _collectionRepository;
  final QuoteRepository _quoteRepository;

  final List<StreamSubscription> subs = [];

  Future<void> init() async {
    final sub = Rx.combineLatest2(
      _collectionRepository.collectionsStream(),
      _quoteRepository.quotesQuantityStream(),
      (collections, quotesQuantity) => (collections, quotesQuantity),
    ).listen(
      (event) {
        final (collections, quotesQuantity) = event;
        emit(HomeState.loaded(collections: collections, quotesQuantity: quotesQuantity));
      },
    );
    subs.add(sub);
  }

  @override
  Future<void> close() {
    for (final sub in subs) {
      sub.cancel();
    }
    return super.close();
  }
}
