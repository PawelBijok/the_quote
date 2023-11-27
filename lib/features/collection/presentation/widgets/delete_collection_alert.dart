import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';

class DeleteCollectionAlert extends StatelessWidget {
  const DeleteCollectionAlert(
      {super.key, required this.name, required this.quotesQuantity, required this.onDeletePressed});
  final String name;
  final int quotesQuantity;
  final VoidCallback onDeletePressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Czy na pewno chcesz usunąć kolekcję: $name',
        style: context.textTheme.titleMedium,
      ),
      content: Text('Ta kolekcja zawiera następującą ilość cytatów: $quotesQuantity'),
      actions: [
        ElevatedButton(onPressed: () => context.pop(), child: const Text('Anuluj')),
        OutlinedButton(
          onPressed: () {
            context.pop();
            onDeletePressed();
          },
          child: const Text('Usuń'),
        ),
      ],
    );
  }
}
