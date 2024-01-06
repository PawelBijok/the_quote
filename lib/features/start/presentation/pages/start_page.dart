import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/fonts/fonts.dart';
import 'package:the_quote/core/images/svg_images.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/features/auth/domain/failures/auth_failure.dart';
import 'package:the_quote/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:the_quote/features/start/presentation/cubit/start_cubit.dart';
import 'package:the_quote/shared/presentation/widgets/buttons/sign_in_with_apple_button.dart';
import 'package:the_quote/shared/presentation/widgets/buttons/sign_in_with_google_button.dart';
import 'package:the_quote/shared/presentation/widgets/common/divider_with_text.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StartCubit>(),
      child: const Scaffold(
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late Animation<double> firstAnimation;
  late Animation<double> secondAnimation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: const Duration(seconds: 4), vsync: this);

    final curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    firstAnimation = Tween<double>(begin: 10, end: 25).animate(
      curve,
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    secondAnimation = Tween<double>(begin: 20, end: 25).animate(
      curve,
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartCubit, StartState>(
      listener: (context, state) {
        if (state.failure != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.failure!.toLocale)));
        }
        if (state.signedInUser != null) {
          context.read<AuthCubit>().tryAutoLogin();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: state.loading ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const LinearProgressIndicator(),
                  ),
                ),
              ),
              Expanded(
                child: DefaultPagePadding(
                  child: Stack(
                    children: [
                      Positioned(
                        right: 10,
                        top: firstAnimation.value,
                        child: SvgPicture.asset(
                          SvgImages.quotes,
                          colorFilter: ColorFilter.mode(
                            context.colorScheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: secondAnimation.value,
                        child: SvgPicture.asset(
                          SvgImages.quotes,
                          colorFilter: ColorFilter.mode(
                            context.colorScheme.primary.withOpacity(0.3),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            LocaleKeys.appName.tr(),
                            style: context.textTheme.displayLarge?.copyWith(fontFamily: Fonts.sourceSerifPro),
                          ),
                          Spacers.s,
                          Text(
                            LocaleKeys.appSlogan.tr(),
                            style: context.textTheme.headlineSmall?.copyWith(fontFamily: Fonts.montserrat),
                          ),
                          Spacers.xxl,
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state.loading ? null : () => context.push(Routes.continueWithEmail),
                              child: Text(
                                LocaleKeys.continueWithEmail.tr(),
                              ),
                            ),
                          ),
                          DividerWithText(
                            text: LocaleKeys.or.tr(),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: SignInWithGoogleButton(
                              onPressed: state.loading ? null : () => context.read<StartCubit>().signInWithGoogle(),
                            ),
                          ),
                          Spacers.m,
                          if (Platform.isIOS)
                            SizedBox(
                              width: double.infinity,
                              child: SignInWithAppleButton(
                                onPressed: state.loading ? null : () => context.read<StartCubit>().signInWithApple(),
                              ),
                            ),
                          Spacers.fromHeight(60),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
