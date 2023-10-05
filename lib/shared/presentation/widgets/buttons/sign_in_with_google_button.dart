import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/images/svg_images.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            SvgImages.googleLogo,
          ),
          Spacers.l,
          Text(
            LocaleKeys.signInWithGoogle.tr(),
            style: context.textTheme.labelLarge?.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
