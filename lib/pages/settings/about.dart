import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/bottom_nav_bar.dart';
import '../../other/get_percentage.dart';
import '../settings_page.dart';
import 'package:package_info/package_info.dart';

class AboutSettingsPage extends StatefulWidget {
  const AboutSettingsPage({super.key});

  @override
  State<AboutSettingsPage> createState() => _AboutSettingsPage();
}

class _AboutSettingsPage extends State<AboutSettingsPage> {

  String version = "", idclient = "";

  Future<void> initPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    version = (await PackageInfo.fromPlatform()).version;
    idclient = prefs.getString("uuid")!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon lycée",
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: const Color(0xff2a3961),
        bottomNavigationBar: const BottomNavBar(),
        body: FutureBuilder(
            future: initPage(),
            builder: (context, snapshot) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: getPercentage(context, "h5")),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            backgroundColor: const Color(0xff2A3961),
                            fixedSize: Size(getPercentage(context, "w100"), getPercentage(context, "h9"))
                        ),
                        onPressed: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const SettingsPage())),
                        child: Text(
                          "Retour",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "FeixenVariable",
                              fontSize: getPercentage(context, "w5")
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "À propos",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenBold",
                          fontSize: getPercentage(context, "w7")),
                    ),
                    SizedBox(height: getPercentage(context, "h2")),
                    SizedBox(
                      width: getPercentage(context, "w90"),
                      child: Text(
                        "MonLycée | Version v$version",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white30,
                            fontFamily: "FeixenVariable",
                            fontSize: getPercentage(context, "w5")
                        ),
                      ),
                    ),
                    SizedBox(height: getPercentage(context, "h1")),
                    SizedBox(
                      width: getPercentage(context, "w90"),
                      child: Text(
                        "ID du client: $idclient",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white30,
                            fontFamily: "FeixenVariable",
                            fontSize: getPercentage(context, "w5")
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}