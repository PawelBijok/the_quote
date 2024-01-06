import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/core/router/dtos/add_or_edit_quote_route_dto.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/collection/presentation/pages/collection/cubit/collection_cubit.dart';
import 'package:the_quote/features/collection/presentation/widgets/delete_collection_alert.dart';
import 'package:the_quote/features/collection/presentation/widgets/quote_list_tile.dart';
import 'package:the_quote/shared/presentation/widgets/common/header_with_button_and_divider.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';
import 'package:transparent_image/transparent_image.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({required this.id, this.preloadedCollection, super.key});

  final String id;
  final CollectionModel? preloadedCollection;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CollectionCubit>()..init(id, preloadedCollection),
      child: BlocBuilder<CollectionCubit, CollectionState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: state.mapOrNull(
                loaded: (state) => Text(state.collection.title),
              ),
              actions: state.mapOrNull(
                loaded: (state) {
                  return [
                    IconButton(
                      onPressed: () {
                        context.push(Routes.addOrEditCollection, extra: state.collection);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (_) => DeleteCollectionAlert(
                            name: state.collection.title,
                            quotesQuantity: state.collection.quotesQuantity,
                            onDeletePressed: () {
                              context.read<CollectionCubit>().deleteCollection();
                              context.pop();
                            },
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ];
                },
              ),
            ),
            body: state.maybeMap(
              orElse: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (state) {
                final hasQuotes = state.quotes.isNotEmpty;

                return DefaultPagePadding(
                  child: ListView(
                    children: [
                      if (state.collection.imageUrl != null)
                        Row(
                          children: [
                            Flexible(
                              child: Container(),
                            ),
                            Flexible(
                              flex: 2,
                              child: AspectRatio(
                                aspectRatio: 2 / 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: state.collection.imageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(),
                            ),
                          ],
                        ),
                      Spacers.xl,
                      if (!hasQuotes) ...[
                        Spacers.xxl,
                        const Divider(),
                        Spacers.xxl,
                        Text(
                          LocaleKeys.youDontHaveAnyQuotesYet.tr(),
                          textAlign: TextAlign.center,
                        ),
                        Spacers.m,
                        ElevatedButton.icon(
                          onPressed: () {
                            context.push(Routes.addOrEditQuote, extra: AddOrEditQuoteRouteDto(collectionId: id));
                          },
                          label: Text(LocaleKeys.addFirstQuote.tr()),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                      if (hasQuotes) ...[
                        HeaderWithButtonAndDivider(
                          title: LocaleKeys.quotes.tr(),
                          onPressed: () {
                            context.push(Routes.addOrEditQuote, extra: AddOrEditQuoteRouteDto(collectionId: id));
                          },
                          icon: Icons.add,
                        ),
                        ...state.quotes.map(
                          (quote) => QuoteListTile(
                            quote: quote,
                            collectionId: id,
                            usage: QuoteListTileUsage.collection,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
