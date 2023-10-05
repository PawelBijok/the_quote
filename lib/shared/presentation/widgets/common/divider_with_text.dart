import 'package:flutter/material.dart';
import 'package:the_quote/core/extensions/extensions.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({
    required this.text,
    super.key,
    this.outerIndent = 10,
    this.innerIndent = 20,
    this.verticalPadding = 20,
    this.thickness = 3,
    this.color,
  });

  final String text;
  final double outerIndent;
  final double innerIndent;
  final double verticalPadding;
  final double thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: color ?? context.colorScheme.surfaceVariant,
              thickness: thickness,
              indent: outerIndent,
              endIndent: innerIndent,
            ),
          ),
          Text(
            text,
            style: context.textTheme.labelMedium,
          ),
          Expanded(
            child: Divider(
              color: color ?? context.colorScheme.surfaceVariant,
              thickness: thickness,
              indent: innerIndent,
              endIndent: outerIndent,
            ),
          ),
        ],
      ),
    );
  }
}
