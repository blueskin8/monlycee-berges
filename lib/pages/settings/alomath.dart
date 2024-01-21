import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:monlycee/other/crypter.dart';
import '../../components/bottom_nav_bar.dart';
import '../../other/get_percentage.dart';

class AlomathSettingsPage extends StatefulWidget {
  const AlomathSettingsPage({super.key});

  @override
  State<AlomathSettingsPage> createState() => _AlomathSettingsPage();
}

class _AlomathSettingsPage extends State<AlomathSettingsPage> {

  final TextEditingController _controllerUsernameAlomath = TextEditingController();
  final TextEditingController _controllerPwdAlomath = TextEditingController();

  bool autoconnexionAlomath = false;

  Future<void> initPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final usernameAlomath = prefs.get("usernameAlomath");
    final pwdAlomath = Encrypter.decrypt(prefs.get("pwdAlomath"));

    autoconnexionAlomath = prefs.getBool("autoconnexionAlomath") ?? false;
    _controllerUsernameAlomath.text = usernameAlomath?.toString() ?? '';
    _controllerPwdAlomath.text = pwdAlomath?.toString() ?? '';
  }

  void setBoolAlomath(value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("autoconnexionAlomath", value);
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
            builder: (context, snapshot) =>
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: getPercentage(context, "h5")),
                        Text(
                          "Paramètres Alomath",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "FeixenBold",
                              fontSize: getPercentage(context, "w7")),
                        ),
                        SizedBox(height: getPercentage(context, "h5")),
                        ElevatedButton(
                          onPressed: () {
                            if (autoconnexionAlomath) {
                              setState(() {
                                autoconnexionAlomath = false;
                              });
                              setBoolAlomath(false);
                            } else {
                              setState(() {
                                autoconnexionAlomath = true;
                              });
                              setBoolAlomath(true);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(getPercentage(context, "w80"),
                                  getPercentage(context, "h5")),
                              backgroundColor: const Color(0xff2A3961),
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
                                value: autoconnexionAlomath,
                                onChanged: (bool? value) {
                                  if (autoconnexionAlomath) {
                                    setState(() {
                                      autoconnexionAlomath = false;
                                    });
                                    setBoolAlomath(false);
                                  } else {
                                    setState(() {
                                      autoconnexionAlomath = true;
                                    });
                                    setBoolAlomath(true);
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
                            controller: _controllerUsernameAlomath,
                            enabled: autoconnexionAlomath,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "Nom d'utilisateur",
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white),
                            onSubmitted: (String value) async {
                              final SharedPreferences prefs = await SharedPreferences
                                  .getInstance();
                              prefs.setString("usernameAlomath", value);
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
                            controller: _controllerPwdAlomath,
                            style: const TextStyle(color: Colors.white),
                            enabled: autoconnexionAlomath,
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: "Mot de passe",
                                labelStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white),
                            onSubmitted: (String value) async {
                              final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              prefs.setString("pwdAlomath", Encrypter.crypt(
                                  value));
                              Fluttertoast.showToast(
                                  msg: "Mot de passe mis à jour !",
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1);
                            },
                          ),
                        ),
                        SizedBox(height: getPercentage(context, "h2")),
                        SizedBox(
                          width: getPercentage(context, "w75"),
                          height: 15,
                          child: InkWell(
                            child: const Text(
                              "Pas de compte Alomath ?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "FeixenVariable"
                              ),
                            ),
                            onTap: () async {
                              await launchUrl(Uri.parse(
                                  "https://alomath.fr/indexLAB.php"));
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                )
        ),
      ),
    );
  }
}