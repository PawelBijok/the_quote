import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/features/collection/presentation/pages/add_new_collection/cubit/add_new_collection_cubit.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';
import 'package:the_quote/shared/presentation/widgets/utils/app_bar_image_picker/app_bar_image_picker.dart';

class AddNewCollectionPage extends StatelessWidget {
  const AddNewCollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddNewCollectionCubit>(),
      child: Builder(
        builder: (context) {
          return BlocListener<AddNewCollectionCubit, AddNewCollectionState>(
            listener: (context, state) {
              state.mapOrNull(success: (_) {
                context.pop();
              });
            },
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text(
                      'Add new collection',
                    ),
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      background: AppBarImagePicker(
                        onUrlChanged: context.read<AddNewCollectionCubit>().onImageUrlChanged,
                      ),
                    ),
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
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPagePadding(
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(
            label: Text('Collection title'),
          ),
          onChanged: context.read<AddNewCollectionCubit>().onTitleChanged,
        ),
        TextFormField(
          decoration: const InputDecoration(
            label: Text('Collection description'),
          ),
          onChanged: context.read<AddNewCollectionCubit>().onDescriptionChanged,
        ),
        Spacers.xxl,
        SizedBox(
          child: ElevatedButton(
            onPressed: context.read<AddNewCollectionCubit>().onSave,
            child: const Text('Save'),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('Cancel'),
        ),
      ]),
    );
  }
}
