import 'package:flutter/material.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/fonts/fonts.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class HeaderWithButtonAndDivider extends StatelessWidget {
  const HeaderWithButtonAndDivider({required this.title, required this.onPressed, required this.icon, super.key});

  final String title;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.headlineSmall
                  ?.copyWith(fontFamily: Fonts.sourceSerifPro, fontWeight: FontWeight.w600),
            ),
            IconButton(
              onPressed: onPressed,
              icon: Icon(icon),
            ),
          ],
        ),
        Divider(
          height: 0,
          color: context.colorScheme.secondaryContainer,
        ),
        Spacers.l,
      ],
    );
  }
}
