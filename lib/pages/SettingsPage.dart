import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsPage extends StatelessWidget {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPwd = TextEditingController();
  SettingsPage({Key? key}) : super(key: key);

  Future<void> getPrefsInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usernameENT = prefs.get("usernameENT");
    final pwdENT = prefs.get("pwdENT");
    _controllerUsername.text = usernameENT.toString();
    _controllerPwd.text = pwdENT.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPrefsInstance(),
      builder: (context, snapshot) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Paramètres",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Text("Paramètres ENT",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: 'Nom d\'utilisateur',
                      ),
                      controller: _controllerUsername,
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
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: 'Mot de passe',
                      ),
                      controller: _controllerPwd,
                      obscureText: true,
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
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
