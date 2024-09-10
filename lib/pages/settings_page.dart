import 'package:flutter/material.dart';
import 'package:monlycee/components/settings_button.dart';
import 'package:monlycee/pages/settings/about.dart';
import 'package:monlycee/pages/settings/alomath.dart';
import 'package:monlycee/pages/settings/beta.dart';
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
        backgroundColor: const Color(0xff1e202b),
        bottomNavigationBar: BottomNavBar(context: context),
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
                      SizedBox(height: getPercentage(context, "h5")),
                      const SettingsButton(
                        buttonText: "Général",
                        icon: Icon(
                          Icons.settings,
                          size: 30,
                          color: Colors.white,
                        ),
                        targetPageInstance: GeneralSettingsPage(),
                        styleSheet: SettingsButtonStyleSheet(borderTop: 1),
                      ),
                      const SettingsButton(
                        buttonText: "ENT",
                        icon: Image(
                          image: AssetImage("assets/entIcon.png"),
                          width: 30, // Taille adaptée
                          height: 30,
                        ),
                        targetPageInstance: EntSettingsPage(),
                      ),
                      const SettingsButton(
                        buttonText: "Turboself",
                        icon: Image(
                          image: AssetImage("assets/turboself_transparent.png"),
                          width: 30,
                          height: 30,
                        ),
                        targetPageInstance: TurboselfSettingsPage(),
                      ),
                      const SettingsButton(
                        buttonText: "Alomath",
                        icon: Image(
                          image: AssetImage("assets/pi_trans.png"),
                          width: 30,
                          height: 30,
                        ),
                        targetPageInstance: AlomathSettingsPage(),
                      ),
                      const SettingsButton(
                        buttonText: "Support",
                        icon: Icon(
                          size: 30,
                          Icons.support_agent,
                          color: Colors.white,
                        ),
                        targetPageInstance: SupportSettingsPage(),
                      ),
                      const SettingsButton(
                        buttonText: "Bêta",
                        icon: Icon(
                          Icons.more_horiz,
                          size: 30,
                          color: Colors.white,
                        ),
                        targetPageInstance: BetaSettingsPage(),
                      ),
                      const SettingsButton(
                        buttonText: "À propos",
                        icon: Icon(
                          Icons.info,
                          size: 30,
                          color: Colors.white,
                        ),
                        targetPageInstance: AboutSettingsPage(),
                        styleSheet: SettingsButtonStyleSheet(borderBottom: 1),
                      ),

                      SizedBox(height: getPercentage(context, "h5")),
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