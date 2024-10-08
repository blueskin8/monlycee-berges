import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/bottom_nav_bar.dart';
import '../../other/get_percentage.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
        backgroundColor: const Color(0xff1e202b),
        bottomNavigationBar: BottomNavBar(context: context),
        body: FutureBuilder(
            future: initPage(),
            builder: (context, snapshot) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: getPercentage(context, "h5")),
                    Text(
                      "À propos de l'application",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenBold",
                          fontSize: getPercentage(context, "w7")),
                    ),
                    SizedBox(height: getPercentage(context, "h5")),
                    SizedBox(
                      width: getPercentage(context, "w90"),
                      child: Text(
                        "MonLycée | Version v$version",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white38,
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
                            color: Colors.white38,
                            fontFamily: "FeixenVariable",
                            fontSize: getPercentage(context, "w5")
                        ),
                      ),
                    ),
                    SizedBox(height: getPercentage(context, "h5")),
                    Text(
                      "À propos de nous",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenBold",
                          fontSize: getPercentage(context, "w7")),
                    ),
                    SizedBox(height: getPercentage(context, "h5")),
                    SizedBox(
                      width: getPercentage(context, "w85"),
                      child: Text(
                        "Développeurs : Alban Garcia et LaFouine-38",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white60,
                          fontFamily: "FeixenVariable",
                          fontSize: getPercentage(context, "w5")
                        ),
                      ),
                    ),
                    SizedBox(height: getPercentage(context, "h1")),
                    SizedBox(
                      width: getPercentage(context, "w85"),
                      child: Text(
                        "Autre projet :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white60,
                          fontFamily: "FeixenVariable",
                          fontSize: getPercentage(context, "w5")
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getPercentage(context, "w75"),
                      child: InkWell(
                        child: Text(
                          "Better ENT",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white60,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                            fontStyle: FontStyle.italic,
                            decorationColor: Colors.white60,
                            fontFamily: "FeixenVariable",
                            fontSize: getPercentage(context, "w5")
                          ),
                        ),
                        onTap: () async {
                          await launchUrl(Uri.parse(
                              "https://github.com/LaFouine-38/Better-ENT"));
                        },
                      ),
                    ),
                    SizedBox(height: getPercentage(context, "h5")),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}