part of 'image_picker_and_uploader_cubit.dart';

@freezed
class ImagePickerAndUploaderState with _$ImagePickerAndUploaderState {
  const factory ImagePickerAndUploaderState.initial() = _Initial;
  const factory ImagePickerAndUploaderState.loading() = _Loading;
  const factory ImagePickerAndUploaderState.loaded({
    required String url,
  }) = _Loaded;
}
