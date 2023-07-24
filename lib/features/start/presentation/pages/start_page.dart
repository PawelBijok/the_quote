import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/fonts/fonts.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/widgets/buttons/sign_in_with_apple_button.dart';
import 'package:the_quote/core/widgets/buttons/sign_in_with_google_button.dart';
import 'package:the_quote/core/widgets/common/divider_with_text.dart';
import 'package:the_quote/core/widgets/layout/default_page_padding.dart';
import 'package:the_quote/core/widgets/layout/spacers.dart';
import 'package:the_quote/features/start/presentation/cubit/start_cubit.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StartCubit>(),
      child: const Scaffold(
        body: _StartPageBody(),
      ),
    );
  }
}

class _StartPageBody extends StatelessWidget {
  const _StartPageBody();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultPagePadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'The Quote',
              style: context.textTheme.displayLarge
                  ?.copyWith(fontFamily: Fonts.sourceSerifPro),
            ),
            Spacers.s,
            Text(
              'Your digital quote vault',
              style: context.textTheme.headlineSmall
                  ?.copyWith(fontFamily: Fonts.montserrat),
            ),
            Spacers.xxl,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Continue with email',
                ),
              ),
            ),
            const DividerWithText(
              text: 'OR',
            ),
            SizedBox(
              width: double.infinity,
              child: SignInWithGoogleButton(
                onPressed: () {},
              ),
            ),
            Spacers.m,
            SizedBox(
              width: double.infinity,
              child: SignInWithAppleButton(
                onPressed: () {},
              ),
            ),
            Spacers.fromHeight(60),
          ],
        ),
      ),
    );
  }
}
