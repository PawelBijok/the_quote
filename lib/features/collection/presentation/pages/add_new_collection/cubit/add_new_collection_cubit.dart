import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/collection/domain/repositories/collection_repository.dart';

part 'add_new_collection_cubit.freezed.dart';
part 'add_new_collection_state.dart';

@injectable
class AddNewCollectionCubit extends Cubit<AddNewCollectionState> {
  AddNewCollectionCubit(this.collectionRepository) : super(const AddNewCollectionState.initial());

  final CollectionRepository collectionRepository;

  void onTitleChanged(String title) {
    state.mapOrNull(
      initial: (state) {
        emit(state.copyWith(collectionTitle: title));
      },
    );
  }

  void onDescriptionChanged(String description) {
    state.mapOrNull(
      initial: (state) {
        emit(state.copyWith(collectionDescription: description));
      },
    );
  }

  void onImageUrlChanged(String imageUrl) {
    state.mapOrNull(
      initial: (state) {
        emit(state.copyWith(imageUrl: imageUrl));
      },
    );
  }

  Future<void> onSave() async {
    await state.mapOrNull(
      initial: (state) async {
        emit(state.copyWith(isLoading: true));
        final failureOrNull = await collectionRepository.addNewCollection(
          CollectionModel(
            id: '',
            title: state.collectionTitle,
            description: state.collectionDescription,
            imageUrl: state.imageUrl,
          ),
        );
        if (failureOrNull.isLeft) {
          return emit(state.copyWith(isLoading: false));
        }

        emit(const AddNewCollectionState.success());
      },
    );
  }
}
