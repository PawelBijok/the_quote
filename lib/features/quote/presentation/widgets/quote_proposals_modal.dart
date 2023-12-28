import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/features/quote/presentation/cubit/add_or_edit_quote_cubit.dart';
import 'package:the_quote/features/quote/presentation/widgets/quote_marker.dart';
import 'package:the_quote/features/quote/presentation/widgets/quote_part_selector.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class QuoteProposalsModal extends StatefulWidget {
  const QuoteProposalsModal({required this.quoteProposals, super.key});

  final QuoteFromPhotoProposals quoteProposals;

  @override
  State<QuoteProposalsModal> createState() => _QuoteProposalsModalState();
}

class _QuoteProposalsModalState extends State<QuoteProposalsModal> {
  final selectedTexts = <UniqueIdText>[];
  String selectedPlainText = '';

  bool showingList = true;
  void toggleShowType() {
    setState(() {
      showingList = !showingList;
    });
  }

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
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: ColoredBox(
            color: context.colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      showingList
                          ? LocaleKeys.selectElementsThatYouWantToAppend.tr()
                          : LocaleKeys.selectPartOfTheTextYouWantToInclude.tr(),
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
                    ),
                  ),
                  IconButton(
                    onPressed: toggleShowType,
                    icon: Icon(
                      showingList ? Icons.format_shapes : Icons.checklist_rtl_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      showingList
                          ? context.pop(selectedTexts)
                          : context.pop([UniqueIdText(id: -1, text: selectedPlainText)]);
                    },
                    icon: Icon(
                      Icons.check,
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showingList)
          Expanded(
            child: ListView(
              children: [
                ...widget.quoteProposals.blocks.mapIndexed(
                  (i, e) => QuoteSelector(
                    element: e,
                    selected: isSelected(e),
                    onChanged: (v) => onChanged(v, e),
                    index: indexOfElement(e),
                    darkenBackground: i.isEven,
                  ),
                ),
              ],
            ),
          ),
        if (!showingList) ...[
          QuoteMarker(
            plainText: widget.quoteProposals.plainText,
            onSelectionChanged: (value) => selectedPlainText = value,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ],
    );
  }
}
