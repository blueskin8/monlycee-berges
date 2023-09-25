import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:nfc_manager/nfc_manager.dart';

class PassPage extends StatefulWidget {
  const PassPage({super.key});

  @override
  State<StatefulWidget> createState() => PassPageState();
}

class PassPageState extends State<PassPage> {
  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<bool>(
        future: NfcManager.instance.isAvailable(),
        builder: (context, ss) => ss.data != true
            ? const Center(child: Text('Votre téléphone n\'est pas compatible NFC ou vous ne l\'avez pas activé'))
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
              ),
      ),
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
