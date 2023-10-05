import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:the_quote/shared/domain/repositories/remote_storage_repository.dart';

part 'image_picker_and_uploader_cubit.freezed.dart';
part 'image_picker_and_uploader_state.dart';

@injectable
class ImagePickerAndUploaderCubit extends Cubit<ImagePickerAndUploaderState> {
  ImagePickerAndUploaderCubit(this.imagePicker, this.remoteStorageRepository)
      : super(const ImagePickerAndUploaderState.initial());

  final ImagePicker imagePicker;
  final RemoteStorageRepository remoteStorageRepository;

  void init(String? initialUrl) {
    if (initialUrl != null) {
      emit(ImagePickerAndUploaderState.loaded(url: initialUrl));
    }
  }

  void deleteCurrentImage() {
    emit(const ImagePickerAndUploaderState.initial());
  }

  void setAndUploadNewImageFromGallery() {
    _pickImageAndUpload(ImageSource.gallery);
  }

  void setAndUploadNewImageFromCamera() {
    _pickImageAndUpload(ImageSource.camera);
  }

  Future<void> _pickImageAndUpload(ImageSource imageSource) async {
    final image = await imagePicker.pickImage(source: imageSource);
    final file = await image?.readAsBytes();
    if (image == null || file == null) {
      return;
    }
    emit(const ImagePickerAndUploaderState.loading());
    final fileUrl = await remoteStorageRepository.uploadFile(
      file: file,
      filename: image.name,
    );
    if (fileUrl.isLeft) {
      return emit(const ImagePickerAndUploaderState.initial());
    }
    emit(ImagePickerAndUploaderState.loaded(url: fileUrl.right));
  }
}
