import 'package:flutter/material.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'dart:convert';
import 'package:nfc_manager/nfc_manager.dart';

class PassPage extends StatefulWidget {
  const PassPage({super.key});

  @override
  State<PassPage> createState() => _PassPageState();
}

ValueNotifier<dynamic> result = ValueNotifier(null);

class _PassPageState extends State<PassPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon lycée",
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: const Color(0xff1e202b),
        bottomNavigationBar: BottomNavBar(context: context),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            FutureBuilder(
              future: NfcManager.instance.isAvailable(),
              builder: (context, ss) => ss.data != true
              ? Center(
                  child: Text(
                    'Votre téléphone n\'est pas\ncompatible NFC ou vous ne\nl\'avez pas activé',

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "FeixenVariable",
                      fontSize: getPercentage(context, "w5")
                    ),
                  )
              )
              : Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.vertical,
                children: [
                Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  constraints: const BoxConstraints.expand(),
                  decoration: BoxDecoration(border: Border.all()),
                  child: SingleChildScrollView(
                    child: ValueListenableBuilder<dynamic>(
                      valueListenable: result,
                      builder: (context, value, _) =>
                          Text('${value ?? ''}'),
                    ),
                  ),
                ),
              ),
                Flexible(
                  flex: 3,
                  child: GridView.count(
                    padding: const EdgeInsets.all(4),
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    children: [
                      ElevatedButton(
                          onPressed: _tagRead, child: const Text('Tag Read'))
                    ],
                  ),
                ),
                ],
              ),)
            ],
        ),
      ),)
    );
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      debugPrint(json.decode(tag.data.toString()).nfca.identifier);
      NfcManager.instance.stopSession();
    });
  }
}