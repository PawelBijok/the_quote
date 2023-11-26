import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/features/collection/presentation/widgets/quote_list_tile.dart';
import 'package:the_quote/features/search/presentation/cubit/search_cubit.dart';
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
          return DefaultPagePadding(
            child: Column(
              children: [
                Spacers.xl,
                TextField(
                  decoration: const InputDecoration(
                    label: Text('Search quote'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  onChanged: context.read<SearchCubit>().onPromptChanged,
                ),
                Spacers.l,
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    final item = state.quotes[index];
                    return QuoteListTile(
                      quote: item,
                      collectionId: item.collectionId,
                    );
                  },
                  itemCount: state.quotes.length,
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}
