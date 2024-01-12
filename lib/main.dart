import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_api_app/view/landing_page.dart';
import 'package:simple_api_app/view/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp( MyApp(
    token: prefs.getString('token'),
  ));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({super.key, required this.token});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/landingPage': (context)=> const LandingPage(),
      },
      home:  (token != null && JwtDecoder.isExpired(token.toString()) == false)
      // JwtDecoder.isExpired(token.toString()) == false
      ? HomePage(mytoken: token.toString())
      : const LandingPage()
    );
  }
}
//65a156f884155d771b2366de
//65a156f884155d771b2366de
