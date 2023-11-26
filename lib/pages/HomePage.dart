import 'package:flutter/material.dart';
import 'package:monlycee/pages/MTagPage.dart';
import 'package:monlycee/pages/EntPage.dart';
import 'package:monlycee/pages/TurboselfPage.dart';
import 'package:monlycee/pages/SettingsPage.dart';
import 'package:monlycee/pages/ShowMoreLinks.dart';
import 'package:monlycee/components/BottomNavBar.dart';
import 'package:monlycee/other/getPercentage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon lycée",
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: const Color(0xff2A3961),
        bottomNavigationBar: const BottomNavBar(),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: getPercentage(context, "h13")),
                    child: Text(
                      "Mon lycée",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "FeixenBold",
                          color: Colors.white,
                          fontSize: getPercentage(context, "w15")
                      ),
                    ),
                  ), // Text Mon lycée
                  Padding(
                    padding: EdgeInsets.only(bottom: getPercentage(context, "h8")),
                    child: Text(
                      "Aristide Bergès",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "FeixenVariable",
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: getPercentage(context, "h3")
                      ),
                    ),
                  ), // Text Aristide Bergès
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7, left: 7),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(left: 20),
                                backgroundColor: const Color(0xff43497D),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(color: Colors.white, width: 1)
                                ),
                                fixedSize: Size(getPercentage(context, "w43"), getPercentage(context, "h15"))
                            ),
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) => ENTPage())
                              )
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/BetterENT-logo.png", width: 40),
                                Padding(padding: const EdgeInsets.only(left: 12), child: Text(
                                  "ENT",
                                  style: TextStyle(
                                      fontFamily: "FeixenVariable",
                                      color: Colors.white,
                                      fontSize: getPercentage(context, "w5")
                                  ),
                                ),)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 7, left: 7),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(left: 20),
                                backgroundColor: const Color(0xff43497D),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(color: Colors.white, width: 1)
                                ),
                                fixedSize: Size(getPercentage(context, "w43"), getPercentage(context, "h15"))
                            ),
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) => TurboselfPage())
                              )
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/turboself.png", width: 40,),
                                Padding(padding: const EdgeInsets.only(left: 12), child: Text(
                                  "Turboself",
                                  style: TextStyle(
                                      fontFamily: "FeixenVariable",
                                      color: Colors.white,
                                      fontSize: getPercentage(context, "w5")
                                  ),
                                ),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ), // Ligne de boutons 1
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7, left: 7),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(left: 20),
                                backgroundColor: const Color(0xff43497D),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(color: Colors.white, width: 1)
                                ),
                                fixedSize: Size(getPercentage(context, "w43"), getPercentage(context, "h15"))
                            ),
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) => MTagPage())
                              )
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/mtag-logo.png", width: 40,),
                                Padding(padding: const EdgeInsets.only(left: 12), child: Text(
                                  "Horaires",
                                  style: TextStyle(
                                      fontFamily: "FeixenVariable",
                                      color: Colors.white,
                                      fontSize: getPercentage(context, "w5")
                                  ),
                                ),)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 7, left: 7),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(left: 20),
                                backgroundColor: const Color(0xff43497D),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(color: Colors.white, width: 1)
                                ),
                                fixedSize: Size(getPercentage(context, "w43"), getPercentage(context, "h15"))
                            ),
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) => SettingsPage())
                              )
                            },
                            child: Row(
                              children: [
                                Image.asset("assets/cogs.png", width: 40,),
                                Padding(padding: const EdgeInsets.only(left: 12), child: Text(
                                  "Préférences",
                                  style: TextStyle(
                                      fontFamily: "FeixenVariable",
                                      color: Colors.white,
                                      fontSize: getPercentage(context, "w4")
                                  ),
                                ),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ), // Ligne de boutons 2
                  const SizedBox(height: 14),
                  SizedBox(
                    width: getPercentage(context, "w86") + 14,
                    height: 25,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        backgroundColor: const Color(0xff43497D)
                      ),
                      onPressed: () => {
                        Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const MoreLinksPage()))
                      },
                      child: const Text(
                        "Afficher plus",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenVariable",
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      )
    );
  }
}