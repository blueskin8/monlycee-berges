import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'dart:convert';

class SettingsPage extends StatelessWidget {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPwd = TextEditingController();

  final TextEditingController _controllerMessage = TextEditingController();
  final TextEditingController _controllerAuthor = TextEditingController();

  SettingsPage({Key? key}) : super(key: key);

  bool autoconnexionENT = false;

  Future<void> getPrefsInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usernameENT = prefs.get("usernameENT");
    final pwdENT = prefs.get("pwdENT");
    autoconnexionENT = prefs.getBool("autoconnexionENT") ?? false;
    _controllerUsername.text = usernameENT.toString();
    _controllerPwd.text = pwdENT.toString();
  }

  Future<http.Response> sendMessage() {
    final String author = _controllerAuthor.text;
    final String message = _controllerMessage.text;
    return http.post(
      Uri.parse("https://discord.com/api/webhooks/1178253911409295380/L24_QviyX6Yuw0GE4yB0WlMCdoKwjVN3N4jKagwbR31vEdWsiQyViP-qdyXVZOUVP4Tr"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "embeds": [
            {
              "title": "Nouveau report",
              "description": message,
              "color": 13377568,
              "author": {
                "name": author
              }
            }
          ]
        }
      )
    );
  }

  void setBool(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("autoconnexionENT", value);
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
                            fontSize: getPercentage(context, "w15")
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "ENT",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "FeixenVariable",
                            fontSize: getPercentage(context, "w7")
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                              "Activer l'autoconnexion",
                              style: TextStyle(
                                  fontFamily: "FeixenVariable",
                                  fontSize: getPercentage(context, "w5"),
                                  color: Colors.white
                              )
                          ),
                          Checkbox(
                            onChanged: (value) {
                              autoconnexionENT = value!;
                              setBool(value);
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) => SettingsPage()
                                  )
                              );
                            },
                            value: autoconnexionENT,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-90,
                        child: TextField(
                          controller: _controllerUsername,
                          enabled: autoconnexionENT,
                          style: const TextStyle(
                              color: Colors.white
                          ),
                          decoration: const InputDecoration(
                              labelText: "Nom d'utilisateur",
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white
                          ),
                          onSubmitted: (String value) async {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("usernameENT", value);
                            Fluttertoast.showToast(
                                msg: "Nom d'utilisateur mis à jour !",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-90,
                        child: TextField(
                          controller: _controllerPwd,
                          style: const TextStyle(
                            color: Colors.white
                          ),
                          enabled: autoconnexionENT,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: "Mot de passe",
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white
                          ),
                          onSubmitted: (String value) async {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("pwdENT", value);
                            Fluttertoast.showToast(
                                msg: "Mot de passe mis à jour !",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1
                            );
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
                          style: const TextStyle(
                              color: Colors.white
                          ),
                          decoration: const InputDecoration(
                              labelText: "Nom",
                              labelStyle: TextStyle(color: Colors.white),
                              fillColor: Colors.white
                          ),
                          controller: _controllerAuthor,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 90,
                        child: TextField(
                          style: const TextStyle(
                              color: Colors.white
                          ),
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
                          backgroundColor: const Color(0xff43497D)
                        ),
                        child: Text(
                          "Envoyer",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "FeixenVariable",
                            fontSize: getPercentage(context, "w5")
                          ),
                        ),
                        onPressed: () => {
                          sendMessage().then((value) => {
                            Fluttertoast.showToast(msg: "Message envoyé !")
                          })
                        },
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