import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/features/collection/domain/models/collection_model.dart';
import 'package:the_quote/features/collection/presentation/pages/collection/cubit/collection_cubit.dart';
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
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                )
              ],
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
                              flex: 1,
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
                              flex: 1,
                            ),
                          ],
                        ),
                      Spacers.xl,
                      if (!hasQuotes) ...[
                        Spacers.xxl,
                        Divider(),
                        Spacers.xxl,
                        const Text(
                          'Nie masz jeszcze żadnych cytatów',
                          textAlign: TextAlign.center,
                        ),
                        Spacers.m,
                        ElevatedButton.icon(
                          onPressed: () {},
                          label: Text('Dodaj pierwszy cytat'),
                          icon: Icon(Icons.add),
                        )
                      ],
                      if (hasQuotes) ...[
                        HeaderWithButtonAndDivider(
                          title: 'Cytaty',
                          onPressed: () => context.push(Routes.addNewCollection),
                          icon: Icons.add,
                        ),
                        ...state.quotes.map(
                          (quote) => QuoteListTile(quote: quote),
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
