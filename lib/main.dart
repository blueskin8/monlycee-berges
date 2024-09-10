import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monlycee/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(const MonLycee());

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  if (prefs.get("unlockScreenRotation") == null) {
    prefs.setBool("unlockScreenRotation", false);
  }
  if (prefs.get("uuid") == null) {
    prefs.setString("uuid", const Uuid().v4());
  }
  if (prefs.get("classe") == null) {
    prefs.setString("classe",
        "seconde"); // Classe par défaut lors de l'installation de l'application
  }

  if (!prefs.getBool("unlockScreenRotation")!) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: const Color(0xff1f202b),
      systemNavigationBarDividerColor: const Color(0xaaffffff)));
}

class MonLycee extends StatelessWidget {
  const MonLycee({Key? key}) : super(key: key);

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
