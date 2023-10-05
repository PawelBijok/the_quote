import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/collection/domain/repositories/collection_repository.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.collectionRepository) : super(const HomeState.initial());
  final CollectionRepository collectionRepository;

  final List<StreamSubscription> subs = [];

  Future<void> init() async {
    final sub = collectionRepository.collectionsStream().listen((collections) {
      emit(HomeState.loaded(collections: collections));
    });
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
