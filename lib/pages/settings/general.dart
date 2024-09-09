import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/bottom_nav_bar.dart';
import '../../other/get_percentage.dart';
import '../settings_page.dart';

class GeneralSettingsPage extends StatefulWidget {
  const GeneralSettingsPage({super.key});

  @override
  State<GeneralSettingsPage> createState() => _GeneralSettingsPage();
}

class _GeneralSettingsPage extends State<GeneralSettingsPage> {
  String classeValue = "";

  Future<void> initPage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    classeValue = prefs.get("classe")!.toString();
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
                    "Paramètres généraux",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "FeixenBold",
                        fontSize: getPercentage(context, "w7")),
                  ),
                  SizedBox(height: getPercentage(context, "h2")),
                  SizedBox(
                    height: getPercentage(context, "h15"),
                    child: Row(
                      children: [
                        Text(
                          "Classe",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'FeixenVariable',
                              fontSize: getPercentage(context, "w5")),
                        ),
                        SizedBox(width: getPercentage(context, "w5")),
                        DropdownMenu(
                          initialSelection: classeValue,
                          onSelected: (String? value) async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            setState(() {
                              prefs.setString("classe", value!);
                            });
                          },
                          width: getPercentage(context, "w40"),
                          menuStyle: const MenuStyle(
                            backgroundColor: WidgetStatePropertyAll( Color(0xff2b2c39) ),
                          ),
                          trailingIcon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                          selectedTrailingIcon: const Icon(Icons.arrow_drop_up, color: Colors.white),
                          textStyle: TextStyle(
                            fontFamily: "FeixenVariable",
                            color: Colors.white,
                            fontSize: getPercentage(context, "w4")
                          ),
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(
                              value: "seconde",
                              label: "Seconde",
                              style: ButtonStyle(
                                foregroundColor: WidgetStatePropertyAll( Color(0xffffffff) ),
                                backgroundColor: WidgetStatePropertyAll( Color(0xff2b2c39) )
                              )
                            ),
                            DropdownMenuEntry(
                              value: "premiere",
                              label: "Première",
                              style: ButtonStyle(
                                  foregroundColor: WidgetStatePropertyAll( Color(0xffffffff) ),
                                  backgroundColor: WidgetStatePropertyAll( Color(0xff2b2c39) )
                              )
                            ),
                            DropdownMenuEntry(
                              value: "terminale",
                              label: "Terminale",
                              style: ButtonStyle(
                                  foregroundColor: WidgetStatePropertyAll( Color(0xffffffff) ),
                                  backgroundColor: WidgetStatePropertyAll( Color(0xff2b2c39) )
                              )
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
