import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacementNamed('/landingPage');
              },
              icon: const Icon(Icons.login_rounded))
        ],
      ),
    );
  }
}
