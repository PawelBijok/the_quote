import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/shared/application/image_picker_and_uploader/image_picker_and_uploader_cubit.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';
import 'package:transparent_image/transparent_image.dart';

class AppBarImagePicker extends StatelessWidget {
  const AppBarImagePicker({
    required this.onUrlChanged,
    this.initialImageUrl,
    super.key,
  });

  final String? initialImageUrl;
  final ValueChanged<String> onUrlChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ImagePickerAndUploaderCubit>()..init(initialImageUrl),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: ColoredBox(
          color: context.colorScheme.primaryContainer,
          child: BlocBuilder<ImagePickerAndUploaderCubit, ImagePickerAndUploaderState>(
            builder: (context, state) {
              return BlocListener<ImagePickerAndUploaderCubit, ImagePickerAndUploaderState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loaded: onUrlChanged,
                  );
                },
                child: state.map(
                  initial: (_) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacers.xxl,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              onPressed: context.read<ImagePickerAndUploaderCubit>().setAndUploadNewImageFromGallery,
                              backgroundColor: context.colorScheme.primary,
                              heroTag: 'pickByGallery',
                              child: Icon(
                                Icons.image,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                            Spacers.m,
                            FloatingActionButton(
                              onPressed: context.read<ImagePickerAndUploaderCubit>().setAndUploadNewImageFromCamera,
                              backgroundColor: context.colorScheme.primary,
                              heroTag: 'pickByCamera',
                              child: Icon(
                                Icons.camera,
                                color: context.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                        Spacers.m,
                        Text(
                          LocaleKeys.addCollectionImage.tr(),
                          style: context.textTheme.labelLarge,
                        ),
                      ],
                    );
                  },
                  loading: (state) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  loaded: (state) {
                    return Stack(
                      children: [
                        const Positioned.fill(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Positioned.fill(
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: state.url,
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 200),
                          ),
                        ),
                        Animate(
                          effects: const [FadeEffect()],
                          delay: const Duration(milliseconds: 500),
                          child: Container(
                            height: context.mediaQuery.padding.top + 60,
                            color: context.colorScheme.background.withOpacity(0.5),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 15,
                          child: FloatingActionButton(
                            onPressed: context.read<ImagePickerAndUploaderCubit>().deleteCurrentImage,
                            child: const Icon(Icons.delete),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
