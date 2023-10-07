import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/collection/domain/repositories/collection_repository.dart';

part 'add_or_edit_collection_cubit.freezed.dart';
part 'add_or_edit_collection_state.dart';

@injectable
class AddOrEditCollectionCubit extends Cubit<AddOrEditCollectionState> {
  AddOrEditCollectionCubit(this.collectionRepository) : super(const AddOrEditCollectionState.initial());

  final CollectionRepository collectionRepository;

  void init(CollectionModel? collection) {
    if (collection == null) {
      return;
    }
    state.mapOrNull(
      initial: (state) {
        emit(
          state.copyWith(
            isEditing: true,
            collectionId: collection.id,
            collectionTitle: collection.title,
            collectionDescription: collection.description,
            imageUrl: collection.imageUrl,
          ),
        );
      },
    );
  }

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
        final collection = CollectionModel(
          id: state.collectionId,
          title: state.collectionTitle,
          description: state.collectionDescription,
          imageUrl: state.imageUrl,
        );
        if (state.isEditing) {
          final failureOrNull = await collectionRepository.editExistingCollection(
            collection,
          );
          if (failureOrNull.isLeft) {
            return emit(state.copyWith(isLoading: false));
          }

          return emit(const AddOrEditCollectionState.success());
        }

        final failureOrNull = await collectionRepository.addNewCollection(
          collection,
        );
        if (failureOrNull.isLeft) {
          return emit(state.copyWith(isLoading: false));
        }

        emit(const AddOrEditCollectionState.success());
      },
    );
  }
}
