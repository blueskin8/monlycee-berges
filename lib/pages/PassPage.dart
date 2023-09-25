import 'package:flutter/material.dart';
import 'dart:typed_data';
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
            ? const Center(child: Text('Votre téléphone n\'est pas compatible NFC'))
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
                            onPressed: _tagRead, child: const Text('Tag Read')),
                        ElevatedButton(
                            onPressed: _ndefWrite,
                            child: const Text('Ndef Write')),
                        ElevatedButton(
                            onPressed: _ndefWriteLock,
                            child: const Text('Ndef Write Lock')),
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
      NfcManager.instance.stopSession();
    });
  }

  void _ndefWrite() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText('Hello World!'),
        NdefRecord.createUri(Uri.parse('https://flutter.dev')),
        NdefRecord.createMime(
            'text/plain', Uint8List.fromList('Hello'.codeUnits)),
        NdefRecord.createExternal(
            'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }

  void _ndefWriteLock() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null) {
        result.value = 'Tag is not ndef';
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }

      try {
        await ndef.writeLock();
        result.value = 'Success to "Ndef Write Lock"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }
}
