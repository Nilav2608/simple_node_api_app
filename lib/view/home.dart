import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String mytoken;
  const HomePage({super.key, required this.mytoken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
    );
  }
}
