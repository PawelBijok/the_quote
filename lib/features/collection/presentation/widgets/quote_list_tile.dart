import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/fonts/fonts.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/core/router/dtos/add_or_edit_quote_route_dto.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/features/collection/presentation/pages/collection/cubit/collection_cubit.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/features/search/presentation/cubit/search_cubit.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

enum QuoteListTileUsage { collection, search }

class QuoteListTile extends StatelessWidget {
  const QuoteListTile({required this.quote, required this.collectionId, required this.usage, super.key});

  final QuoteModel quote;
  final String collectionId;
  final QuoteListTileUsage usage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 5),
      title: Text(
        '„${quote.content}”',
        style: context.textTheme.bodyLarge?.copyWith(
          fontStyle: FontStyle.italic,
          fontFamily: Fonts.sourceSerifPro,
        ),
      ),
      subtitle: Text(
        DateFormat.yMMMd().format(quote.createdAt),
        style: context.textTheme.labelSmall,
      ),
      trailing: MenuAnchor(
        alignmentOffset: const Offset(-50, 0),
        builder: (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.more_horiz),
            tooltip: LocaleKeys.showMenu.tr(),
          );
        },
        menuChildren: [
          MenuItemButton(
            onPressed: () => usage == QuoteListTileUsage.collection
                ? context.read<CollectionCubit>().deleteQuote(quote.id)
                : context.read<SearchCubit>().deleteQuote(
                      quoteId: quote.id,
                      parentCollectionId: quote.collectionId,
                    ),
            child: Row(
              children: [
                const Icon(
                  Icons.delete,
                  size: 20,
                ),
                Spacers.s,
                Text(LocaleKeys.delete.tr()),
              ],
            ),
          ),
          MenuItemButton(
            onPressed: () {
              context.push(
                Routes.addOrEditQuote,
                extra: AddOrEditQuoteRouteDto(
                  collectionId: collectionId,
                  quoteToEdit: quote,
                ),
              );
            },
            child: Row(
              children: [
                const Icon(
                  Icons.edit,
                  size: 20,
                ),
                Spacers.s,
                Text(LocaleKeys.edit.tr()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
