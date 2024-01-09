import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_api_app/AuthPageBloc/auth_page_bloc.dart';
import 'package:simple_api_app/view/login_page.dart';
import 'package:simple_api_app/view/signup_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  AuthPageBloc authPageBloc = AuthPageBloc();

  @override
  void initState() {
    super.initState();
    authPageBloc.add(ShowRegisterPageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthPageBloc, AuthPageState>(
      bloc: authPageBloc,
      listenWhen: (previous, current) => current is AuthPageActionState,
      buildWhen: (previous, current) => current is! AuthPageActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case ShowLogInPageActionState:
            return Scaffold(
              body: LogInPage(
                showSingUpPage: () {
                authPageBloc.add(ShowRegisterPageEvent());
              }),
            );
          case ShowRegisterPageActionState:
            return SignUpPage(
              showLoginPage: () {
                authPageBloc.add(ShowLoginPageEvent());
              }
               
            );
        }
        return const SizedBox();
      },
    );
  }
}
