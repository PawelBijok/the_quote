import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/collection/presentation/pages/add_or_edit_collection/cubit/add_or_edit_collection_cubit.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';
import 'package:the_quote/shared/presentation/widgets/utils/app_bar_image_picker/app_bar_image_picker.dart';

class AddOrEditCollectionPage extends StatelessWidget {
  const AddOrEditCollectionPage({required this.collectionToEdit, super.key});

  final CollectionModel? collectionToEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddOrEditCollectionCubit>()..init(collectionToEdit),
      child: Builder(
        builder: (context) {
          return BlocListener<AddOrEditCollectionCubit, AddOrEditCollectionState>(
            listener: (context, state) {
              state.mapOrNull(
                success: (_) {
                  context.pop();
                },
              );
            },
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  BlocBuilder<AddOrEditCollectionCubit, AddOrEditCollectionState>(
                    builder: (context, state) {
                      final (isEditing, initialImageUrl) = state.maybeMap(
                        initial: (state) => (state.isEditing, state.imageUrl),
                        orElse: () => (false, null),
                      );

                      return SliverAppBar(
                        title: Text(
                          isEditing ? LocaleKeys.editCollection.tr() : LocaleKeys.addNewCollection.tr(),
                        ),
                        expandedHeight: 300,
                        flexibleSpace: FlexibleSpaceBar(
                          background: AppBarImagePicker(
                            initialImageUrl: initialImageUrl,
                            onUrlChanged: context.read<AddOrEditCollectionCubit>().onImageUrlChanged,
                          ),
                        ),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: _Body(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOrEditCollectionCubit, AddOrEditCollectionState>(
      builder: (context, state) {
        final (title, description) = state.maybeMap(
          initial: (state) => (state.collectionTitle, state.collectionDescription),
          orElse: () => (null, null),
        );
        return DefaultPagePadding(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text(LocaleKeys.collectionTitle.tr()),
                ),
                initialValue: title,
                onChanged: context.read<AddOrEditCollectionCubit>().onTitleChanged,
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text(LocaleKeys.collectionDescription.tr()),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                initialValue: description,
                onChanged: context.read<AddOrEditCollectionCubit>().onDescriptionChanged,
              ),
              Spacers.xxl,
              SizedBox(
                child: ElevatedButton(
                  onPressed: context.read<AddOrEditCollectionCubit>().onSave,
                  child: Text(LocaleKeys.save.tr()),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(LocaleKeys.cancel.tr()),
              ),
            ],
          ),
        );
      },
    );
  }
}
