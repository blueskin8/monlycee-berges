import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monlycee/pages/settings_page.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/bottom_nav_bar.dart';
import '../../other/get_percentage.dart';
import 'package:http/http.dart' as http;

class SupportSettingsPage extends StatefulWidget {
  const SupportSettingsPage({super.key});

  @override
  State<SupportSettingsPage> createState() => _SupportSettingsPageState();
}

class _SupportSettingsPageState extends State<SupportSettingsPage> {

  final TextEditingController _controllerMessage = TextEditingController();
  final TextEditingController _controllerAuthor = TextEditingController();

  String IPAddress = "";
  String version = "";
  String idclient = "";

  Future<void> initPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    version = (await PackageInfo.fromPlatform()).version;
    idclient = prefs.getString("uuid")!;
  }

  Future<void> sendMessage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String author = _controllerAuthor.text;
    final String message = _controllerMessage.text;

    final response = await http.get(Uri.parse('https://httpbin.org/ip'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      IPAddress = data['origin'];
    }

    var res = await http.get(Uri.parse("https://raw.githubusercontent.com/blueskin8/monlycee-berges/main/blacklist.txt"));
    debugPrint(res.body);

    if(res.body.contains(prefs.get('uuid').toString())) {
      Fluttertoast.showToast(msg: "Vous avez été banni du système de rapport");
    } else {
      await http.post(
          Uri.parse(
              "https://discord.com/api/webhooks/1179105539943305236/LFhtU-8_gQhVwL-ntgHhWNQOPcrF3IpGRAToMUKfFVWwZqDRduMSHm3miHIoEn3Iqjrm"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(
              {
                "embeds": [
                  {
                    "title": "Nouveau report",
                    "color": 12594220,
                    "fields": [
                      {
                        "name": "Adresse e-mail",
                        "value": author
                      },
                      {
                        "name": "Adresse IP",
                        "value": IPAddress
                      },
                      {
                        "name": "UUID",
                        "value": prefs.get("uuid")
                      },
                      {
                        "name": "Version de l'application",
                        "value": "v$version"
                      },
                      {
                        "name": "Message",
                        "value": message
                      }
                    ]
                  }
                ]
              }
          )
      );
      _controllerMessage.text = "";
      _controllerAuthor.text = "";
      Fluttertoast.showToast(msg: "Message envoyé !");
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
                    "Un bug ? Une idée ?\nEnvoyez-nous un message",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "FeixenVariable",
                      fontSize: getPercentage(context, "w7"),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getPercentage(context, "h5")),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 90,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white),
                      controller: _controllerAuthor,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 90,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Message",
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                      ),
                      controller: _controllerMessage,
                    ),
                  ),
                  SizedBox(height: getPercentage(context, "h1")),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff43497D)),
                    child: Text(
                      "Envoyer",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenVariable",
                          fontSize: getPercentage(context, "w5")),
                    ),
                    onPressed: () =>
                    {
                      if(_controllerMessage.text == "" ||
                          _controllerAuthor.text == "") {
                        Fluttertoast.showToast(msg: "Vous devez préciser qui vous êtes et votre message.")
                      } else
                        {
                          sendMessage()
                        }
                    },
                  ),
                  SizedBox(height: getPercentage(context, "h5"))
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}