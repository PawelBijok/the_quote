import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/core/l10n/locale_keys.g.dart';
import 'package:the_quote/core/validators/text/text_validation_error.dart';
import 'package:the_quote/features/reset_password/presentation/cubit/reset_password_cubit.dart';
import 'package:the_quote/shared/presentation/widgets/layout/default_page_padding.dart';
import 'package:the_quote/shared/presentation/widgets/layout/spacers.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ResetPasswordCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Zapomniałeś hasła?')),
        body: DefaultPagePadding(
          child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
              state.mapOrNull(
                success: (_) {
                  //TODO show messeage;

                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Email z linkiem resetującym hasło został wysłany')));
                  context.pop();
                },
                failure: (_) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Coś poszło nie tak!')));
                },
              );
            },
            builder: (context, state) {
              return state.maybeMap(
                  initial: (state) {
                    print(state);
                    return Form(
                      autovalidateMode: state.showErrors ? AutovalidateMode.always : AutovalidateMode.disabled,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              label: Text(LocaleKeys.email.tr()),
                              errorText: state.showErrors ? state.emailValidation?.toKey().tr() : null,
                            ),
                            onChanged: context.read<ResetPasswordCubit>().onEmailChanged,
                          ),
                          Spacers.xl,
                          ElevatedButton(
                            onPressed: context.read<ResetPasswordCubit>().onSubmit,
                            child: const Text(
                              'Resetuj hasło',
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  orElse: () => const SizedBox.shrink());
            },
          ),
        ),
      ),
    );
  }
}
