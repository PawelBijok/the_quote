import 'package:flutter/material.dart';
import 'package:the_quote/core/injectable/injectable.dart';
import 'package:the_quote/features/auth/presentation/cubit/auth_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('settings'),
          ElevatedButton(
              onPressed: () {
                // FirebaseAuth.instance.signOut();
                // context.replace(Routes.start);
                getIt<AuthCubit>().logout();
              },
              child: Text("Sign out"))
        ],
      ),
    );
  }
}
