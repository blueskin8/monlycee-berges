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
                          menuStyle: MenuStyle(
                            backgroundColor: const MaterialStatePropertyAll( Color(0xff43497D) ),
                            minimumSize: MaterialStatePropertyAll(Size(getPercentage(context, "w40"), 1)),
                            maximumSize: MaterialStatePropertyAll(Size(getPercentage(context, "w40"), getPercentage(context, "h50")))
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
                                foregroundColor: MaterialStatePropertyAll( Color(0xffffffff) ),
                                backgroundColor: MaterialStatePropertyAll( Color(0xff43497D) )
                              )
                            ),
                            DropdownMenuEntry(
                              value: "premiere",
                              label: "Première",
                              style: ButtonStyle(
                                  foregroundColor: MaterialStatePropertyAll( Color(0xffffffff) ),
                                  backgroundColor: MaterialStatePropertyAll( Color(0xff43497D) )
                              )
                            ),
                            DropdownMenuEntry(
                              value: "terminale",
                              label: "Terminale",
                              style: ButtonStyle(
                                  foregroundColor: MaterialStatePropertyAll( Color(0xffffffff) ),
                                  backgroundColor: MaterialStatePropertyAll( Color(0xff43497D) )
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
