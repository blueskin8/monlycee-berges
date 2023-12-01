import 'package:flutter/material.dart';
import 'package:monlycee/pages/settings/alomath.dart';
import 'package:monlycee/pages/settings/ent.dart';
import 'package:monlycee/pages/settings/support.dart';
import 'package:monlycee/pages/settings/turboself.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String version = "";

  String idclient = "";

  @override
  void initState() {
    super.initState();
    getPrefsInstance();
  }

  Future<void> getPrefsInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    version = (await PackageInfo.fromPlatform()).version;
    idclient = prefs.get("uuid").toString();
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const EntSettingsPage()))
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(getPercentage(context, "w100"), getPercentage(context, "h9")),
                            backgroundColor: const Color(0xff2A3961),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: const BorderSide(
                                    color: Colors.white,
                                    width: 1
                                )
                            )
                        ),
                        child: Text(
                          "ENT",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "FeixenVariable",
                              fontSize: getPercentage(context, "w7")
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: const Border(bottom: BorderSide(color: Colors.white, width: 1), left: BorderSide(color: Colors.white, width: 1), right: BorderSide(color: Colors.white, width: 1))
                        ),
                        width: getPercentage(context, "w100"),
                        height: getPercentage(context, "h9"),
                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const TurboselfSettingsPage()))
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(getPercentage(context, "w100"), getPercentage(context, "h9")),
                              backgroundColor: const Color(0xff2A3961),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                              )
                          ),
                          child: Text(
                            "Turboself",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "FeixenVariable",
                                fontSize: getPercentage(context, "w7")
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: const Border(bottom: BorderSide(color: Colors.white, width: 1), left: BorderSide(color: Colors.white, width: 1), right: BorderSide(color: Colors.white, width: 1))
                        ),
                        width: getPercentage(context, "w100"),
                        height: getPercentage(context, "h9"),
                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const AlomathSettingsPage()))
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(getPercentage(context, "w100"), getPercentage(context, "h9")),
                              backgroundColor: const Color(0xff2A3961),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                              )
                          ),
                          child: Text(
                            "Alomath",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "FeixenVariable",
                                fontSize: getPercentage(context, "w7")
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: const Border(bottom: BorderSide(color: Colors.white, width: 1), left: BorderSide(color: Colors.white, width: 1), right: BorderSide(color: Colors.white, width: 1))
                        ),
                        width: getPercentage(context, "w100"),
                        height: getPercentage(context, "h9"),
                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const SupportPage()))
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(getPercentage(context, "w100"), getPercentage(context, "h9")),
                              backgroundColor: const Color(0xff2A3961),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                              )
                          ),
                          child: Text(
                            "Support",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "FeixenVariable",
                                fontSize: getPercentage(context, "w7")
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: getPercentage(context, "h2")),
                      Text(
                        "MonLycée | Version v$version",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white30,
                          fontFamily: "FeixenVariable",
                          fontSize: getPercentage(context, "w4")
                        ),
                      ),
                      Text(
                        "ID du client: $idclient",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white30,
                            fontFamily: "FeixenVariable",
                            fontSize: getPercentage(context, "w3")
                        ),
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