import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_api_app/AuthPageBloc/auth_page_bloc.dart';

class HomePage extends StatefulWidget {
  final String mytoken;
  const HomePage({super.key, required this.mytoken});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initPrefs();
    super.initState();
  }

  final AuthPageBloc bloc = AuthPageBloc();

  logOut() {
    Navigator.of(context).pushReplacementNamed('/landingPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await prefs.remove('token');

                logOut();
              },
              icon: const Icon(Icons.login_rounded))
        ],
      ),
    );
  }
}
