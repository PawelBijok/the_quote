import 'package:flutter/material.dart';

class DefaultPagePadding extends StatelessWidget {
  const DefaultPagePadding({required this.child, this.additionalPadding, super.key});

  final Widget child;

  final EdgeInsets? additionalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: additionalPadding ?? EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
