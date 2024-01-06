import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/images/svg_images.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class SignInWithAppleButton extends StatelessWidget {
  const SignInWithAppleButton({required this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isLight = context.isLight;
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => isLight ? Colors.black : Colors.white),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isLight ? SvgImages.whiteAppleLogo : SvgImages.blackAppleLogo,
          ),
          Spacers.l,
          Text(
            LocaleKeys.signInWithApple.tr(),
            style: context.textTheme.labelLarge?.copyWith(
              color: isLight ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
