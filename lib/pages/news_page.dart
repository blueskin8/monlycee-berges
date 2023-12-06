import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> releases = [];

  var versions = Padding(padding: EdgeInsets.zero);

  Future<void> initPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var res = await http.get(Uri.parse("https://api.github.com/repos/blueskin8/monlycee-berges/releases"));
    try {
      if(jsonDecode(res.body)["message"].startsWith("API rate limit")) {
        versions = Padding(
          padding: EdgeInsets.zero,
          child: Center(
            child: SizedBox(
              width: getPercentage(context, "w90"),
              child: Text(
                "Limite de requête de l'API GitHub atteinte, veillez réessayer plus tard.",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "FeixenVariable",
                    fontSize: getPercentage(context, "w10")
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }
    } catch(err) {

    }
    releases = jsonDecode(res.body);
    versions = Padding(
        padding: EdgeInsets.symmetric(vertical: getPercentage(context, "h2")),
        child: Column(
        children: [
          for(var release in releases) Padding(
            padding: EdgeInsets.symmetric(vertical: getPercentage(context, "h1")),
            child: Container(
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
                  SizedBox(height: getPercentage(context, "h2")),
                  Text(
                    "Version ${release["tag_name"]}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "FeixenBold",
                        fontSize: getPercentage(context, "w5")
                    ),
                  ),
                  SizedBox(height: getPercentage(context, "h2")),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      release["body"],
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenVariable",
                          fontSize: getPercentage(context, "w4")
                      ),
                    ),
                  ),
                  SizedBox(height: getPercentage(context, "h2")),
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
                    onPressed: () async {
                      await launchUrl(Uri.parse(release["html_url"]));
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
                  SizedBox(height: getPercentage(context, "h2"),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon lycée",
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        bottomNavigationBar: const BottomNavBar(),
        backgroundColor: const Color(0xff2A3961),
        body: FutureBuilder(
          future: initPage(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  versions
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}