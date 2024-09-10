import 'package:flutter/material.dart';
import 'package:monlycee/other/crypter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/bottom_nav_bar.dart';
import '../../other/get_percentage.dart';

class EntSettingsPage extends StatefulWidget {
  const EntSettingsPage({super.key});

  @override
  State<EntSettingsPage> createState() => _EntSettingsPage();
}

class _EntSettingsPage extends State<EntSettingsPage> {

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPwd = TextEditingController();

  bool autoconnexionENT = false;

  Future<void> initPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final usernameENT = prefs.get("usernameENT");
    final pwdENT = prefs.get("pwdENT");

    autoconnexionENT = prefs.getBool("autoconnexionENT") ?? false;
    _controllerUsername.text = usernameENT?.toString() ?? '';
    _controllerPwd.text = Encrypter.decrypt(pwdENT?.toString()) ?? '';
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
        backgroundColor: const Color(0xff1e202b),
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
                      "Paramètres ENT",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenBold",
                          fontSize: getPercentage(context, "w7")),
                    ),
                    SizedBox(height: getPercentage(context, "h5")),
                    ElevatedButton(
                      onPressed: () {
                        if(autoconnexionENT) {
                          setState(() {
                            autoconnexionENT = false;
                          });
                          setBool(false);
                        } else {
                          setState(() {
                            autoconnexionENT = true;
                          });
                          setBool(true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(getPercentage(context, "w80"), getPercentage(context, "h5")),
                          backgroundColor: const Color(0xff1e202b),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                          )
                      ),
                      child: Row(
                        children: [
                          Text(
                              "Activer l'autoconnexion",
                              style: TextStyle(
                                  fontFamily: "FeixenVariable",
                                  fontSize: getPercentage(context, "w5"),
                                  color: Colors.white)),
                          Checkbox(
                            value: autoconnexionENT, onChanged: (bool? value) {
                              if(autoconnexionENT) {
                                setState(() {
                                  autoconnexionENT = false;
                                });
                                setBool(false);
                              } else {
                                setState(() {
                                  autoconnexionENT = true;
                                });
                                setBool(true);
                              }
                            },
                          ),
                        ],
                      ),
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
                        onChanged: (String value) async {
                          final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                          prefs.setString("usernameENT", value);
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
                        onChanged: (String value) async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("pwdENT", Encrypter.crypt(value));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}