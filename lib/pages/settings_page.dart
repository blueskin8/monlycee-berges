import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'package:package_info/package_info.dart';
import 'dart:convert';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPwd = TextEditingController();

  final TextEditingController _controllerUsernameSelf = TextEditingController();
  final TextEditingController _controllerPwdSelf = TextEditingController();

  final TextEditingController _controllerMessage = TextEditingController();
  final TextEditingController _controllerAuthor = TextEditingController();

  late String IPAddress;

  String version = "";

  String idclient = "";

  bool autoconnexionENT = false;
  bool autoconnexionSelf = false;

  @override
  void initState() {
    super.initState();
    getPrefsInstance();
  }

  Future<void> getPrefsInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usernameENT = prefs.get("usernameENT");
    final pwdENT = prefs.get("pwdENT");
    final usernameSelf = prefs.get("usernameSelf");
    final pwdSelf = prefs.get("pwdSelf");

    version = (await PackageInfo.fromPlatform()).version;
    idclient = prefs.get("uuid").toString();

    autoconnexionENT = prefs.getBool("autoconnexionENT") ?? false;
    _controllerUsername.text = usernameENT?.toString() ?? '';
    _controllerPwd.text = pwdENT?.toString() ?? '';

    autoconnexionSelf = prefs.getBool("autoconnexionSelf") ?? false;
    _controllerUsernameSelf.text = usernameSelf?.toString() ?? '';
    _controllerPwdSelf.text = pwdSelf?.toString() ?? '';
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

  void setBool(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("autoconnexionENT", value);
  }

  void setBoolSelf(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("autoconnexionSelf", value);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: getPercentage(context, "h13")),
                      Text(
                        "Paramètres",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "FeixenBold",
                            fontSize: getPercentage(context, "w15")),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "ENT",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "FeixenVariable",
                            fontSize: getPercentage(context, "w7")),
                      ),
                      Row(
                        children: [
                          Text(
                              "Activer l'autoconnexion",
                              style: TextStyle(
                                  fontFamily: "FeixenVariable",
                                  fontSize: getPercentage(context, "w5"),
                                  color: Colors.white)),
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                autoconnexionENT = value!;
                              });
                              setBool(value);
                            },
                            value: autoconnexionENT,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 90,
                        child: TextField(
                          controller: _controllerUsername,
                          enabled: autoconnexionENT,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: "Nom d'utilisateur",
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white),
                          onSubmitted: (String value) async {
                            final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.setString("usernameENT", value);
                            Fluttertoast.showToast(
                                msg: "Nom d'utilisateur mis à jour !",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1);
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 90,
                        child: TextField(
                          controller: _controllerPwd,
                          style: const TextStyle(color: Colors.white),
                          enabled: autoconnexionENT,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: "Mot de passe",
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white),
                          onSubmitted: (String value) async {
                            final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.setString("pwdENT", value);
                            Fluttertoast.showToast(
                                msg: "Mot de passe mis à jour !",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Turboself",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "FeixenVariable",
                            fontSize: getPercentage(context, "w7")),
                      ),
                      Row(
                        children: [
                          Text(
                              "Activer l'autoconnexion",
                              style: TextStyle(
                                  fontFamily: "FeixenVariable",
                                  fontSize: getPercentage(context, "w5"),
                                  color: Colors.white)),
                          Checkbox(
                            onChanged: (value) {
                              setState(() {
                                autoconnexionSelf = value!;
                              });
                              setBoolSelf(value);
                            },
                            value: autoconnexionSelf,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 90,
                        child: TextField(
                          controller: _controllerUsernameSelf,
                          enabled: autoconnexionSelf,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              labelText: "Adresse email",
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white),
                          onSubmitted: (String value) async {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("usernameSelf", value);
                            Fluttertoast.showToast(
                                msg: "Adresse email mis à jour !",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1);
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width - 90,
                        child: TextField(
                          controller: _controllerPwdSelf,
                          style: const TextStyle(color: Colors.white),
                          enabled: autoconnexionSelf,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: "Mot de passe",
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white),
                          onSubmitted: (String value) async {
                            final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            prefs.setString("pwdSelf", value);
                            Fluttertoast.showToast(
                                msg: "Mot de passe mis à jour !",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1);
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Un bug ? Une idée ?\nEnvoyez-nous un message",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenVariable",
                          fontSize: getPercentage(context, "w7"),
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                      SizedBox(height: getPercentage(context, "h2")),
                      Text(
                        "MonLycée | Version v$version",
                        style: TextStyle(
                          color: Colors.white30,
                          fontFamily: "FeixenVariable",
                          fontSize: getPercentage(context, "w4")
                        ),
                      ),
                      Text(
                        "ID du client: $idclient",
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