import 'package:flutter/material.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/features/quote/presentation/cubit/add_or_edit_quote_cubit.dart';

class QuoteSelector extends StatelessWidget {
  const QuoteSelector({
    required this.element,
    required this.selected,
    required this.onChanged,
    required this.index,
    required this.darkenBackground,
  });

  final UniqueIdText element;
  final bool selected;
  final ValueChanged<bool?> onChanged;
  final int? index;
  final bool darkenBackground;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: darkenBackground ? context.colorScheme.primary.withOpacity(0.07) : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Text(element.text),
      titleAlignment: ListTileTitleAlignment.top,
      trailing: Badge(
        isLabelVisible: index != null,
        offset: const Offset(-2, 2),
        label: Text(index.toString()),
        child: Checkbox.adaptive(
          value: selected,
          checkColor: context.colorScheme.primary,
          activeColor: context.colorScheme.primaryContainer,
          shape: const CircleBorder(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
