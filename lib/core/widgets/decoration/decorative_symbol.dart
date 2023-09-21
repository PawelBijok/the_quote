import 'package:flutter/material.dart';
import 'package:the_quote/core/extensions/extensions.dart';

class DecorativeSymbol extends StatelessWidget {
  const DecorativeSymbol(this.symbol, {super.key});

  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 3.14 / 7,
      origin: Offset(0, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text(
          //   symbol,
          //   style: TextStyle(
          //     fontSize: 75,
          //     height: 1,
          //     fontWeight: FontWeight.w400,
          //     color: context.colorScheme.tertiary,
          //   ),
          // ),
          // Text(
          //   symbol,
          //   style: TextStyle(
          //     fontSize: 100,
          //     height: 1,
          //     fontWeight: FontWeight.w400,
          //     color: context.colorScheme.tertiary,
          //   ),
          // ),
          Text(
            symbol,
            style: TextStyle(
              fontSize: 125,
              height: 1,
              fontWeight: FontWeight.w400,
              color: context.colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
