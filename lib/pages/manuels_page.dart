import 'package:flutter/material.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/components/manuel_button.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'package:monlycee/pages/settings/support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:monlycee/other/manuels.dart' as manuels_lib;

class ManuelsPage extends StatefulWidget {
  const ManuelsPage({super.key});

  @override
  State<ManuelsPage> createState() => _ManuelsPageState();
}

class _ManuelsPageState extends State<ManuelsPage> {

  String classe = "";
  var manuels = {};

  Future<void> initPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    classe = prefs.get("classe")!.toString();
    manuels = manuels_lib.manuels;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon lycée",
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        backgroundColor: const Color(0xff2a3961),
        body: FutureBuilder(
          future: initPage(),
          builder: (context, snapshot) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: getPercentage(context, "h13"), bottom: getPercentage(context, "h6")),
                        child: Text(
                          "Manuels",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "FeixenBold",
                              fontSize: getPercentage(context, "w15")
                          ),
                        ),
                      ),

                      if(classe == "seconde") Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 7, left: 7),
                                child: ManuelButton(buttonText: "Maths", percentageRefContext: context, manuelUrl: manuels["seconde"]["maths"]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 7, left: 7),
                                child: ManuelButton(buttonText: "SVT", percentageRefContext: context, manuelUrl: manuels["seconde"]["svt"]),
                              )
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 7, left: 7),
                                child: ManuelButton(buttonText: "Histoire", percentageRefContext: context, manuelUrl: manuels["seconde"]["histoire"]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 7, left: 7),
                                child: ManuelButton(buttonText: "Espagnol", percentageRefContext: context, manuelUrl: manuels["seconde"]["espagnol"]),
                              )
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 7, left: 7),
                                child: ManuelButton(buttonText: "Physique Chimie", percentageRefContext: context, manuelUrl: manuels["seconde"]["spc"]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 7, left: 7),
                                child: ManuelButton(buttonText: "Français", percentageRefContext: context, manuelUrl: manuels["seconde"]["francais"]),
                              )
                            ],
                          ),
                        ],
                      ),
                      if(classe == "premiere") Column(
                        children: [
                          Text(
                            "Aucun manuel publié",
                            style: TextStyle(
                              fontFamily: "FeixenVariable",
                              color: Colors.white,
                              fontSize: getPercentage(context, "w5")
                            ),
                          )
                        ],
                      ),
                      if(classe == "terminale") Column(
                        children: [
                          Text(
                            "Aucun manuel publié",
                            style: TextStyle(
                                fontFamily: "FeixenVariable",
                                color: Colors.white,
                                fontSize: getPercentage(context, "w5")
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 14),
                      SizedBox(
                        height: 25,
                        width: getPercentage(context, "w86") + 14,
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const SupportSettingsPage())),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              backgroundColor: const Color(0xff43497D)
                          ),
                          child: const Text(
                            "Publier un manuel",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "FeixenVariable"
                            ),
                          ),
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
