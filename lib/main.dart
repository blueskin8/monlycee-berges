import 'package:flutter/material.dart';
import 'package:monlycee/pages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MonLycee(prefs: prefs));
}

class MonLycee extends StatelessWidget {
  final SharedPreferences prefs;

  const MonLycee({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon lycée',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}