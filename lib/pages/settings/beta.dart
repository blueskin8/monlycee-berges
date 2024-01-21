import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/bottom_nav_bar.dart';
import '../../other/get_percentage.dart';

class BetaSettingsPage extends StatefulWidget {
  const BetaSettingsPage({super.key});

  @override
  State<BetaSettingsPage> createState() => _BetaSettingsPage();
}

class _BetaSettingsPage extends State<BetaSettingsPage> {
  bool unlockScreenRotation = false;

  Future<void> initPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    unlockScreenRotation = prefs.getBool("unlockScreenRotation")!;
  }

  void updateUnlockScreenRotation(bool newvalue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("unlockScreenRotation", newvalue);
    if(newvalue) {
      SystemChrome.setPreferredOrientations([]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon lycée",
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: const Color(0xff2a3961),
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
                    "Paramètres Bêta",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "FeixenBold",
                      fontSize: getPercentage(context, "w7")),
                  ),
                  SizedBox(height: getPercentage(context, "h5")),
                  Row(
                    children: [
                      Text(
                        "Débloquer la rotation de l'écran",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenVariable",
                          fontSize: getPercentage(context, "w5")),
                      ),
                      Checkbox(
                        value: unlockScreenRotation,
                        onChanged: (value) => {
                          setState(() {
                            unlockScreenRotation = value!;
                          }),
                          updateUnlockScreenRotation(value!)
                        },
                      )
                    ],
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
