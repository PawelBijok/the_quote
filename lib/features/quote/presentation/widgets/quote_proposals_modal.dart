import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/features/quote/presentation/cubit/add_or_edit_quote_cubit.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class QuoteProposalsModal extends StatefulWidget {
  const QuoteProposalsModal({super.key, required this.quoteProposals});

  final QuoteFromPhotoProposals quoteProposals;

  @override
  State<QuoteProposalsModal> createState() => _QuoteProposalsModalState();
}

class _QuoteProposalsModalState extends State<QuoteProposalsModal> {
  final selectedTexts = <UniqueIdText>[];

  void addToSelected(UniqueIdText text) {
    setState(() {
      selectedTexts.add(text);
    });
  }

  void removeFromSelected(UniqueIdText text) {
    setState(() {
      selectedTexts.remove(text);
    });
  }

  int? indexOfElement(UniqueIdText text) {
    final index = selectedTexts.indexOf(text);
    if (index == -1) {
      return null;
    }
    return index + 1;
  }

  bool isSelected(UniqueIdText text) {
    return selectedTexts.contains(text);
  }

  // ignore: avoid_positional_boolean_parameters
  void onChanged(bool? value, UniqueIdText text) {
    if (value == null) {
      return;
    }
    value ? addToSelected(text) : removeFromSelected(text);
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = context.theme.textTheme;
    return DefaultPagePadding(
      child: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  'Select elements that you want to append',
                  style: textStyles.labelLarge,
                ),
              ),
              Spacers.l,
              IconButton(
                  onPressed: () {
                    context.pop(null);
                  },
                  icon: Icon(
                    Icons.close,
                    color: context.colorScheme.error,
                  )),
              IconButton(
                  onPressed: () {
                    context.pop(selectedTexts);
                  },
                  icon: Icon(
                    Icons.check,
                    color: context.colorScheme.tertiary,
                  ))
            ],
          ),
          Spacers.xl,
          Text(
            'Lines',
            style: textStyles.labelLarge,
          ),
          ...widget.quoteProposals.lines.map(
            (e) => _QuoteSelector(
              element: e,
              selected: isSelected(e),
              onChanged: (v) => onChanged(v, e),
              index: indexOfElement(e),
            ),
          ),
          Spacers.xl,
          Text(
            'Blocks',
            style: textStyles.labelLarge,
          ),
          ...widget.quoteProposals.blocks.map(
            (e) => _QuoteSelector(
              element: e,
              selected: isSelected(e),
              onChanged: (v) => onChanged(v, e),
              index: indexOfElement(e),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuoteSelector extends StatelessWidget {
  const _QuoteSelector(
      {required this.element, super.key, required this.selected, required this.onChanged, required this.index});

  final UniqueIdText element;
  final bool selected;
  final ValueChanged<bool?> onChanged;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(element.text),
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
