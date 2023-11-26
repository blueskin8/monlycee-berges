import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:github/github.dart';
import 'package:monlycee/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MonLycee(prefs: prefs));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  checkForUpdate();
}

void checkForUpdate() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final latestRelease = await GitHub().repositories.getLatestRelease(RepositorySlug('blueskin8', 'monlycee-berges'));
  final latestVersion = latestRelease.tagName;
  String appVersion = "v${packageInfo.version}";
  if (latestVersion == appVersion) {
    debugPrint("c'est la meme chose");
  } else {
    debugPrint("$packageInfo | $appVersion");
  }
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