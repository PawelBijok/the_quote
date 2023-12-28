import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';

class DeleteCollectionAlert extends StatelessWidget {
  const DeleteCollectionAlert({
    required this.name,
    required this.quotesQuantity,
    required this.onDeletePressed,
    super.key,
  });
  final String name;
  final int quotesQuantity;
  final VoidCallback onDeletePressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        LocaleKeys.areYouSureYouWantToDeleteCollection.tr(namedArgs: {'collection': name}),
        style: context.textTheme.titleMedium,
      ),
      content: Text(LocaleKeys.thisCollectionContains.tr(namedArgs: {'quotes': quotesQuantity.toString()})),
      actions: [
        ElevatedButton(onPressed: () => context.pop(), child: Text(LocaleKeys.cancel.tr())),
        OutlinedButton(
          onPressed: () {
            context.pop();
            onDeletePressed();
          },
          child: Text(LocaleKeys.delete.tr()),
        ),
      ],
    );
  }
}
