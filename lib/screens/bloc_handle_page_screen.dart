import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/helpers/loading/loadin_screen.dart';
import 'package:new_project/screens/email_verification.dart';
import 'package:new_project/screens/forget_password_view.dart';
import 'package:new_project/screens/home_screens/front_page.dart';
import 'package:new_project/screens/login_page.dart';
import 'package:new_project/screens/sign_up.dart';

import 'package:new_project/services/auth/bloc/auth_bloc.dart';

class BlocPageHandleScreen extends StatelessWidget {
  const BlocPageHandleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.isLoading) {
        LoadingScreen().show(
            context: context,
            text: state.loadingtext ?? 'Please wait a moment');
      } else {
        LoadingScreen().hide();
      }
    }, builder: ((context, state) {
      if (state is AuthStateLoggedIn) {
        return MainNotes();
      } else if (state is AuthStatNeedsVerification) {
        return EmailVerification();
      } else if (state is AuthStatLoggedOut) {
        return LoginPage();
      } else if (state is AuthStateRegistering) {
        return SignUp();
      } else if (state is AuthStateForgotPassword) {
        return ForgotPasswordView();
      } else {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    }));
  }
}
