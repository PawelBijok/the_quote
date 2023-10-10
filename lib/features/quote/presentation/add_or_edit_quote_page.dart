import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/features/quote/presentation/cubit/add_or_edit_quote_cubit.dart';

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
      child: Scaffold(
        body: Center(
          child: Text('add or edit quote'),
        ),
      ),
    );
  }
}
