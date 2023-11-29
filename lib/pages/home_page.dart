import 'package:flutter/material.dart';
import 'package:monlycee/pages/mtag_page.dart';
import 'package:monlycee/pages/ent_page.dart';
import 'package:monlycee/pages/turboself_page.dart';
import 'package:monlycee/pages/settings_page.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'package:monlycee/pages/math_manuel.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';
import 'package:github/github.dart';
import 'package:monlycee/pages/alomath_page.dart';
import 'package:monlycee/pages/news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool updateAvailable = false;
  bool showMore = false;

  String latestVersion = "";
  String versionDescription = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initPage(),
      builder: (context, snapshot) {
        return MaterialApp(
            title: "Mon lycée",
            darkTheme: ThemeData.dark(),
            home: Scaffold(
                backgroundColor: const Color(0xff2A3961),
                bottomNavigationBar: const BottomNavBar(),
                body: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
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
                            Text(
                              "Aristide Bergès",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: "FeixenVariable",
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: getPercentage(context, "h3")
                              ),
                            ), // Text Aristide Bergès
                            SizedBox(height: getPercentage(context, "h6")),
                            if(updateAvailable) SizedBox(
                            height: 25,
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  GitHub().repositories.getLatestRelease(RepositorySlug('blueskin8', 'monlycee-berges')).then((release) => {
                                    OtaUpdate().execute(release.assets?[0].browserDownloadUrl as String)
                                  });
                                } catch (err) {
                                  debugPrint("une erreur est survenue lors de la maj auto");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff678FFF),
                                  fixedSize: Size(getPercentage(context, "w86") + 14, 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                  )
                              ),
                              child: Text(
                                "Une nouvelle version est disponible",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "FeixenVariable",
                                    fontSize: getPercentage(context, "w3")
                                ),
                              ),
                            ),
                          ),
                            SizedBox(height: getPercentage(context, "h2")),
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
                                          Padding(
                                            padding: const EdgeInsets.only(left: 12),
                                            child: Text(
                                              "Turboself",
                                              style: TextStyle(
                                                  fontFamily: "FeixenVariable",
                                                  color: Colors.white,
                                                  fontSize: getPercentage(context, "w5")
                                              ),
                                            ),
                                          )
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
                                            PageRouteBuilder(pageBuilder: (_, __, ___) => const SettingsPage())
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
                            if(showMore) Column(
                              children: [
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
                                              PageRouteBuilder(pageBuilder: (_, __, ___) => AlomathPage())
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
                                const SizedBox(height: 14)
                              ],
                            ),
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
                                  if(showMore) {
                                    setState(() => showMore = false)
                                  } else {
                                    setState(() => showMore = true)
                                  }
                                },
                                child: Text(
                                  showMore ? "Afficher moins" : "Afficher plus",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: "FeixenVariable",
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: getPercentage(context, "h5")),
                            Container(
                              width: getPercentage(context, "w86") + 14,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff43497D),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1
                                )
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      latestVersion!="" ? "Version $latestVersion" : "Chargement...",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "FeixenVariable",
                                          fontSize: getPercentage(context, "w6")
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      versionDescription!="" ? versionDescription : "Chargement...",
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "FeixenVariable",
                                      fontSize: getPercentage(context, "w4")
                                    ),
                                  ),
                                  ),
                                  const SizedBox(height: 14),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(getPercentage(context, "w80"), 15),
                                      backgroundColor: const Color(0xff43497D),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(9),
                                        side: const BorderSide(
                                          color: Colors.white,
                                          width: 1
                                        )
                                      )
                                    ),
                                    onPressed: () {
                                      Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => NewsPage()));
                                    },
                                    child: Text(
                                      "En savoir plus",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "FeixenVariable",
                                        fontSize: getPercentage(context, "w5")
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: getPercentage(context, "w3"),)
                                ],
                              ),
                            ),
                            const SizedBox(height: 14)
                          ],
                        ),
                      ],
                    ),
                  )
                )
            )
        );
      },
    );
  }

  Future<void> initPage() async {
    WidgetsFlutterBinding.ensureInitialized();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    latestVersion = (await GitHub().repositories.getLatestRelease(RepositorySlug('blueskin8', 'monlycee-berges'))).tagName!;
    versionDescription = (await GitHub().repositories.getLatestRelease(RepositorySlug('blueskin8', 'monlycee-berges'))).body!;

    if(latestVersion == "" && versionDescription == "") {
      setState(() {
        latestVersion;
        versionDescription;
      });
    }

    if(!updateAvailable) {
      latestVersion = (await GitHub().repositories.getLatestRelease(RepositorySlug('blueskin8', 'monlycee-berges'))).tagName!;
      String appVersion = "v${packageInfo.version}";
      debugPrint("Current app version : $appVersion | Latest app version : $latestVersion");
      if (latestVersion != appVersion) {
        setState(() {
          updateAvailable=true;
        });
      }
    }
  }
}