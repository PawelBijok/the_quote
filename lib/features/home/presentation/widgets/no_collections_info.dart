import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/fonts/fonts.dart';
import 'package:the_quote/core/images/svg_images.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class NoCollectionsInfo extends StatefulWidget {
  const NoCollectionsInfo({super.key});

  @override
  State<NoCollectionsInfo> createState() => NoCollectionsInfoState();
}

class NoCollectionsInfoState extends State<NoCollectionsInfo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.addYourFirstCollection.tr(),
                  style: context.textTheme.titleMedium?.copyWith(fontFamily: Fonts.sourceSerifPro),
                  textAlign: TextAlign.right,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 35, bottom: 30, left: 10),
                  child: SvgPicture.asset(
                    SvgImages.arrowTopRight,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                    height: 70,
                  ),
                ),
              ),
            ],
          ),
          Spacers.xxl,
          Spacers.xxl,
          SvgPicture.asset(
            SvgImages.marksWind,
            colorFilter: ColorFilter.mode(
              context.colorScheme.secondary.withOpacity(context.theme.brightness == Brightness.light ? 0.3 : 1),
              BlendMode.srcIn,
            ),
            height: 160,
          ),
          Spacers.l,
          Text(
            LocaleKeys.youDoNotHaveANyCollectionsYet.tr(),
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.secondary.withOpacity(context.theme.brightness == Brightness.light ? 0.6 : 1),
            ),
          ),
        ],
      ),
    );
  }
}
