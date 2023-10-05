import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/fonts/fonts.dart';
import 'package:the_quote/features/quote/domain/models/quote_model.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class QuoteListTile extends StatelessWidget {
  const QuoteListTile({required this.quote, super.key});

  final QuoteModel quote;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
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
          alignmentOffset: Offset(-50, 0),
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
              tooltip: 'Show menu',
            );
          },
          menuChildren: [
            MenuItemButton(
              onPressed: () {},
              child: const Row(children: [
                Icon(
                  Icons.delete,
                  size: 20,
                ),
                Spacers.s,
                Text('Usuń'),
              ]),
            ),
            MenuItemButton(
              onPressed: () {},
              child: const Row(children: [
                Icon(
                  Icons.edit,
                  size: 20,
                ),
                Spacers.s,
                Text('Edytuj'),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
