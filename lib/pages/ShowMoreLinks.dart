import 'package:flutter/material.dart';
import 'package:monlycee/pages/HomePage.dart';
import 'package:monlycee/pages/MathManuel.dart';
import 'package:monlycee/components/BottomNavBar.dart';
import 'package:monlycee/other/getPercentage.dart';
import 'package:monlycee/pages/EntPage.dart';
import 'package:monlycee/pages/TurboselfPage.dart';
import 'package:monlycee/pages/SettingsPage.dart';
import 'package:monlycee/pages/AlomathPage.dart';
import 'package:monlycee/pages/MTagPage.dart';

class MoreLinksPage extends StatelessWidget {
  const MoreLinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Plus de liens",
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        backgroundColor: const Color(0xff2A3961),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: getPercentage(context, "h13")),
                  Text(
                    "Mon lycée",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "FeixenBold",
                        color: Colors.white,
                        fontSize: getPercentage(context, "w15")
                    ),
                  ),
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
                  ), // Text "Aristide Bergès"
                  Row(
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
                              Image.asset("assets/BetterENT-logo.png", width: 40,),
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
                  ), // Ligne de boutons 1
                  const SizedBox(height: 14),
                  Row(
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
                  ), // Ligne de boutons 2
                  const SizedBox(height: 14),
                  Row(
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
                                PageRouteBuilder(pageBuilder: (_, __, ___) => MathManuelPage())
                            )
                          },
                          child: Row(
                            children: [
                              Image.asset("assets/mathbook.png", width: 40,),
                              Padding(padding: const EdgeInsets.only(left: 12), child: Text(
                                "Manuel",
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
                                PageRouteBuilder(pageBuilder: (_, __, ___) =>AlomathPage())
                            )
                          },
                          child: Row(
                            children: [
                              Image.asset("assets/alomath.png", width: 40,),
                              Padding(padding: const EdgeInsets.only(left: 12), child: Text(
                                "Alomath",
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
                  ), // Ligne de boutons 3


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
                        Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const HomePage()))
                      },
                      child: const Text(
                        "Afficher moins",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenVariable",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: getPercentage(context, "h10"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
