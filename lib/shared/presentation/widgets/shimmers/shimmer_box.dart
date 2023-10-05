import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:the_quote/core/extensions/extensions.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({this.width = 130, this.height = 7, super.key});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.onBackground.withOpacity(0.1),
      highlightColor: context.colorScheme.onBackground.withOpacity(0.3),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(3),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
