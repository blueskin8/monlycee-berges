import 'package:flutter/material.dart';
import 'package:monlycee/components/settings_button.dart';
import 'package:monlycee/pages/settings/about.dart';
import 'package:monlycee/pages/settings/alomath.dart';
import 'package:monlycee/pages/settings/ent.dart';
import 'package:monlycee/pages/settings/general.dart';
import 'package:monlycee/pages/settings/support.dart';
import 'package:monlycee/pages/settings/turboself.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    getPrefsInstance();
  }

  Future<void> getPrefsInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
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
          future: getPrefsInstance(),
          builder: (context, snapshot) {
            return Row(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: getPercentage(context, "h13")),
                      Text(
                        "Paramètres",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "FeixenBold",
                            fontSize: getPercentage(context, "w15")),
                      ),
                      SizedBox(height: getPercentage(context, "h7")),
                      const SettingsButton(
                          buttonText: "Général",
                          targetPageInstance: GeneralSettingsPage(),
                          styleSheet: SettingsButtonStyleSheet(borderTop: 1)),
                      const SettingsButton(
                          buttonText: "ENT",
                          targetPageInstance: EntSettingsPage()),
                      const SettingsButton(
                          buttonText: "Turboself",
                          targetPageInstance: TurboselfSettingsPage()),
                      const SettingsButton(
                          buttonText: "Alomath",
                          targetPageInstance: AlomathSettingsPage()),
                      const SettingsButton(
                          buttonText: "Support",
                          targetPageInstance: SupportSettingsPage()),
                      const SettingsButton(
                        buttonText: "À propos",
                        targetPageInstance: AboutSettingsPage(),
                        styleSheet: SettingsButtonStyleSheet(borderBottom: 1),
                      ),
                      SizedBox(height: getPercentage(context, "h3")),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.discord),
                            iconSize: getPercentage(context, "w10"),
                            color: Colors.white,
                            onPressed: () async {
                              await launchUrl(Uri.parse("https://discord.gg/MvYmceb6Ba"));
                            },
                          ),
                          const SizedBox(width: 14),
                          IconButton(
                            icon: const ImageIcon(AssetImage("assets/github.png")),
                            iconSize: getPercentage(context, "w10"),
                            color: Colors.white,
                            onPressed: () async {
                              await launchUrl(Uri.parse("https://github.com/blueskin8/monlycee-berges"));
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: getPercentage(context, "h5"))
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
