import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/images/svg_images.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';

class NoSerachResultsInfo extends StatelessWidget {
  const NoSerachResultsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          SvgImages.noSearchResults,
          colorFilter: ColorFilter.mode(
            context.colorScheme.secondary,
            BlendMode.srcIn,
          ),
          height: 180,
        ),
        Text(
          LocaleKeys.noQuotesFound.tr(),
          style: context.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
