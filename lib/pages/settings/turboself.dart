import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monlycee/other/crypter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/bottom_nav_bar.dart';
import '../../other/get_percentage.dart';

class TurboselfSettingsPage extends StatefulWidget {
  const TurboselfSettingsPage({super.key});

  @override
  State<TurboselfSettingsPage> createState() => _TurboselfSettingsPage();
}

class _TurboselfSettingsPage extends State<TurboselfSettingsPage> {

  final TextEditingController _controllerUsernameSelf = TextEditingController();
  final TextEditingController _controllerPwdSelf = TextEditingController();

  bool autoconnexionSelf = false;

  Future<void> initPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final usernameSelf = prefs.get("usernameSelf");
    final pwdSelf = prefs.get("pwdSelf");

    autoconnexionSelf = prefs.getBool("autoconnexionSelf") ?? false;
    _controllerUsernameSelf.text = usernameSelf?.toString() ?? '';
    _controllerPwdSelf.text = Encrypter.decrypt(pwdSelf?.toString()) ?? '';
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
                      "Paramètres Turboself",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenBold",
                          fontSize: getPercentage(context, "w7")),
                    ),
                    SizedBox(height: getPercentage(context, "h2")),
                    ElevatedButton(
                      onPressed: () {
                        if(autoconnexionSelf) {
                          setState(() {
                            autoconnexionSelf = false;
                          });
                          setBoolSelf(false);
                        } else {
                          setState(() {
                            autoconnexionSelf = true;
                          });
                          setBoolSelf(true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(getPercentage(context, "w80"), getPercentage(context, "h5")),
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
                            value: autoconnexionSelf, onChanged: (bool? value) {
                              if(autoconnexionSelf) {
                                setState(() {
                                  autoconnexionSelf = false;
                                });
                                setBoolSelf(false);
                              } else {
                                setState(() {
                                  autoconnexionSelf = true;
                                });
                                setBoolSelf(true);
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
                          prefs.setString("pwdSelf", Encrypter.crypt(value));
                          Fluttertoast.showToast(
                              msg: "Mot de passe mis à jour !",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1);
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