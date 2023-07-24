import 'package:flutter/material.dart';

class DefaultPagePadding extends StatelessWidget {
  const DefaultPagePadding({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: child,
    );
  }
}
