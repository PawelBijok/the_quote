// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/fonts/fonts.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/features/quote/presentation/cubit/add_or_edit_quote_cubit.dart';
import 'package:the_quote/features/quote/presentation/widgets/quote_proposals_modal.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

typedef OnSelectedCallback = void Function(List<UniqueIdText>? selectedTexts);

class AddOrEditQuotePage extends StatefulWidget {
  const AddOrEditQuotePage({required this.collectionId, super.key, this.quoteToEdit});

  final String collectionId;
  final QuoteModel? quoteToEdit;

  @override
  State<AddOrEditQuotePage> createState() => _AddOrEditQuotePageState();
}

class _AddOrEditQuotePageState extends State<AddOrEditQuotePage> {
  bool isDrawerOpened = false;

  Future<void> showSheet(
    QuoteFromPhotoProposals quoteProposals, {
    required OnSelectedCallback onSelected,
  }) async {
    setState(() {
      isDrawerOpened = true;
    });
    final selectedTexts = await showModalBottomSheet<List<UniqueIdText>?>(
      context: context,
      builder: (ctx) {
        return QuoteProposalsModal(
          quoteProposals: quoteProposals,
        );
      },
      isDismissible: false,
    );
    onSelected(selectedTexts);
    setState(() {
      isDrawerOpened = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddOrEditQuoteCubit>()
        ..init(
          collectionId: widget.collectionId,
          quoteToEdit: widget.quoteToEdit,
        ),
      child: BlocConsumer<AddOrEditQuoteCubit, AddOrEditQuoteState>(
        listener: (context, state) {
          if (state.quoteProposals != null && isDrawerOpened == false) {
            showSheet(
              state.quoteProposals!,
              onSelected: context.read<AddOrEditQuoteCubit>().onSelectedTexts,
            );
          }
          if (state.status == AddOrEditQuoteStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.isEditing ? LocaleKeys.quoteSavedSuccessfully.tr() : LocaleKeys.newQuoteAddedSuccessfully.tr(),
                ),
              ),
            );
            context.pop();
          } else if (state.status == AddOrEditQuoteStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LocaleKeys.somethingWentWrong.tr()),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.isEditing ? LocaleKeys.editQuote.tr() : LocaleKeys.addNewQuote.tr()),
            ),
            body: DefaultPagePadding(
              child: ListView(
                children: [
                  Spacers.s,
                  TextFormField(
                    key: Key(state.refreshInputKey),
                    decoration: InputDecoration(
                      label: Text(LocaleKeys.quoteContent.tr()),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: context.textTheme.headlineSmall
                        ?.copyWith(fontFamily: Fonts.sourceSerifPro, fontStyle: FontStyle.italic),
                    initialValue: state.content,
                    onChanged: context.read<AddOrEditQuoteCubit>().onContentChanged,
                  ),
                  SizedBox(
                    height: 50,
                    child: VerticalDivider(
                      thickness: 2,
                      color: context.colorScheme.primaryContainer,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      // color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.fromBorderSide(
                        BorderSide(color: context.colorScheme.primary),
                      ),
                    ),
                    // height: 200,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            LocaleKeys.getFromPhoto.tr(),
                            style: context.textTheme.titleMedium,
                          ),
                          Spacers.l,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  context.read<AddOrEditQuoteCubit>().getFromImage();
                                },
                                heroTag: null,
                                child: const Icon(Icons.image),
                              ),
                              const FloatingActionButton(
                                heroTag: null,
                                onPressed: null,
                                child: Icon(Icons.camera_alt),
                              ),
                            ],
                          ),
                          Spacers.l,
                          Text(
                            LocaleKeys.aiWillFindAnyTextInThePhoto.tr(),
                            textAlign: TextAlign.center,
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacers.xxl,
                  ElevatedButton(
                    onPressed: context.read<AddOrEditQuoteCubit>().save,
                    child: Text(LocaleKeys.save.tr()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
