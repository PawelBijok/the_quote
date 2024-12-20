import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/features/collection/presentation/widgets/quote_list_tile.dart';
import 'package:the_quote/features/search/presentation/cubit/search_cubit.dart';
import 'package:the_quote/features/search/presentation/widgets/no_serach_results_info.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>()..init(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return SafeArea(
            child: DefaultPagePadding(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      label: Text(LocaleKeys.searchQuote.tr()),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    onChanged: context.read<SearchCubit>().onPromptChanged,
                  ),
                  Spacers.l,
                  if (state.quotes.isEmpty)
                    const Expanded(child: NoSerachResultsInfo())
                  else
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final item = state.quotes[index];
                          return QuoteListTile(
                            quote: item,
                            collectionId: item.collectionId,
                            usage: QuoteListTileUsage.search,
                          );
                        },
                        itemCount: state.quotes.length,
                      ),
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
