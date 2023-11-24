import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/fonts/fonts.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/features/quote/presentation/cubit/add_or_edit_quote_cubit.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class AddOrEditQuotePage extends StatelessWidget {
  const AddOrEditQuotePage({super.key, required this.collectionId, this.quoteToEdit});

  final String collectionId;
  final QuoteModel? quoteToEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddOrEditQuoteCubit>()
        ..init(
          collectionId: collectionId,
          quoteToEdit: quoteToEdit,
        ),
      child: BlocConsumer<AddOrEditQuoteCubit, AddOrEditQuoteState>(
        listener: (context, state) {
          if (state.status == AddOrEditQuoteStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.isEditing ? 'Pomyślnie zapisano cytat' : 'Pomyślnie dodano nowy cytat do kolecji'),
              ),
            );
            context.pop();
          } else if (state.status == AddOrEditQuoteStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Coś poszło nie tak, spróbuj ponownie później'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.isEditing ? 'Edytuj cytat' : 'Dodaj nowy cytat'),
            ),
            body: DefaultPagePadding(
              child: ListView(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Quote content'),
                      border: OutlineInputBorder(
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
                  SizedBox(height: 50, child: VerticalDivider()),
                  Container(
                    decoration: BoxDecoration(
                      // color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.fromBorderSide(
                        BorderSide(color: context.colorScheme.onSurface),
                      ),
                    ),
                    // height: 200,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Get from photo',
                            style: context.textTheme.titleMedium,
                          ),
                          Spacers.l,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                onPressed: () {},
                                heroTag: null,
                                child: Icon(Icons.image),
                              ),
                              FloatingActionButton(
                                heroTag: null,
                                onPressed: null,
                                child: Icon(Icons.camera_alt),
                              ),
                            ],
                          ),
                          Spacers.l,
                          Text(
                            'AI will find any text in the photo ',
                            textAlign: TextAlign.center,
                            style: context.textTheme.labelMedium,
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacers.xxl,
                  ElevatedButton(
                    onPressed: context.read<AddOrEditQuoteCubit>().save,
                    child: const Text('Zapisz'),
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
