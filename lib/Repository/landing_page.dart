import 'package:flutter/material.dart';
import 'package:simple_api_app/view/login_page.dart';
import 'package:simple_api_app/view/signup_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool showLoginPage = true;

  void toggleSwitch() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LogInPage(showRegisterPage: toggleSwitch,);
    } else {
      return SignUpPage(showLoginPage: toggleSwitch,);
    }
  }
}
