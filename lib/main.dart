import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monlycee/other/just_wait.dart';
import 'package:monlycee/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );

  runApp(const MonLycee());

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  if(!prefs.getBool("unlockScreenRotation")!) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  if(prefs.get("uuid")==null) {
    prefs.setString("uuid", const Uuid().v4());
  }
  if(prefs.get("classe")==null) {
    prefs.setString("classe", "seconde"); // Classe par défaut lors de l'installation de l'application
  }
  while (true) {
    await justWait(1000);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
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