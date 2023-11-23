import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/extensions/extensions.dart';
import 'package:the_quote/core/fonts/fonts.dart';
import 'package:the_quote/core/images/svg_images.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/core/router/routes.dart';
import 'package:the_quote/core/validators/text/text_validation_error.dart';
import 'package:the_quote/features/email_base_auth/presentation/cubit/continue_with_email_cubit.dart';
import 'package:the_quote/features/email_base_auth/presentation/errors/continue_with_email_error.dart';
import 'package:the_quote/shared/presentation/widgets/common/divider_with_text.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class ContinueWithEmailPage extends StatelessWidget {
  const ContinueWithEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ContinueWithEmailCubit>(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: const Center(
          child: _Body(),
        ),
        bottomNavigationBar: const _BottomBar(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final isKeyboard = KeyboardVisibilityProvider.isKeyboardVisible(context);

    return BlocConsumer<ContinueWithEmailCubit, ContinueWithEmailState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!.toLocaleKey.tr())));
        }
        if (state.success) {
          context.go(Routes.main);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuart,
              top: isKeyboard ? -20 : -30,
              left: isKeyboard ? 170 : 30,
              right: isKeyboard ? 10 : 0,
              child: AnimatedOpacity(
                opacity: isKeyboard ? 0.5 : 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutQuart,
                child: SvgPicture.asset(
                  SvgImages.atSnake,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: DefaultPagePadding(
                child: Center(
                  child: Form(
                    autovalidateMode: state.showFormErrors ? AutovalidateMode.always : AutovalidateMode.disabled,
                    child: ListView(
                      children: [
                        _AnimatedGap(
                          isCollapsed: isKeyboard,
                          sizeExpanded: 60,
                          sizeCollapsed: 0,
                        ),
                        Text(
                          state.isSigningIn ? LocaleKeys.signIn.tr() : LocaleKeys.register.tr(),
                          style: context.textTheme.displayLarge?.copyWith(
                            fontFamily: Fonts.sourceSerifPro,
                          ),
                        ),
                        _AnimatedGap(
                          isCollapsed: isKeyboard,
                          sizeExpanded: 30,
                          sizeCollapsed: 5,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text(LocaleKeys.email.tr()),
                            errorText: state.formValidation?.email?.toKey().tr(),
                          ),
                          onChanged: context.read<ContinueWithEmailCubit>().handleEmailChange,
                        ),
                        Spacers.m,
                        TextFormField(
                          decoration: InputDecoration(
                            label: Text(LocaleKeys.password.tr()),
                            errorText: state.formValidation?.password?.toKey().tr(),
                          ),
                          onChanged: context.read<ContinueWithEmailCubit>().handlePasswordChange,
                        ),
                        Spacers.l,
                        if (state.isSigningIn)
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                context.push(Routes.resetPassword);
                              },
                              child: Text(LocaleKeys.forgotPassword.tr()),
                            ),
                          ),
                        if (!state.isSigningIn)
                          TextFormField(
                            decoration: InputDecoration(
                              label: Text(LocaleKeys.confirmPassword.tr()),
                              errorText: state.formValidation?.passwordConfirmation?.toKey().tr(),
                            ),
                            onChanged: context.read<ContinueWithEmailCubit>().handlePasswordConfirmationChange,
                          ),
                        Spacers.l,
                        AnimatedOpacity(
                          opacity: state.isLoading ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const LinearProgressIndicator(),
                        ),
                        Spacers.s,
                        AnimatedOpacity(
                          opacity: state.isLoading ? 0.3 : 1,
                          duration: const Duration(milliseconds: 200),
                          child: OutlinedButton(
                            onPressed: context.read<ContinueWithEmailCubit>().validateAndSingInOrSignUp,
                            child: Text(
                              state.isSigningIn ? LocaleKeys.signIn.tr() : LocaleKeys.register.tr(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AnimatedGap extends StatelessWidget {
  const _AnimatedGap({
    required this.isCollapsed,
    required this.sizeExpanded,
    this.sizeCollapsed = 1,
  });

  final bool isCollapsed;
  final double? sizeCollapsed;
  final double sizeExpanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isCollapsed ? sizeCollapsed : sizeExpanded,
      width: isCollapsed ? sizeCollapsed : sizeExpanded,
      curve: Curves.easeOutQuart,
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContinueWithEmailCubit, ContinueWithEmailState>(
      builder: (context, state) {
        return SafeArea(
          child: AnimatedOpacity(
            opacity: state.isLoading ? 0.3 : 1,
            duration: const Duration(milliseconds: 200),
            child: DefaultPagePadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DividerWithText(
                    text: state.isSigningIn ? LocaleKeys.dontHaveAnAccount.tr() : LocaleKeys.alreadyHaveAnAccount.tr(),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<ContinueWithEmailCubit>().toggleSignInAndRegister();
                    },
                    child: Text(
                      state.isSigningIn ? LocaleKeys.register.tr() : LocaleKeys.signIn.tr(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
