import 'package:flutter/material.dart';
import 'package:monlycee/other/check_internet_connection.dart';
import 'package:monlycee/other/crypter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/other/just_wait.dart';

import '../other/get_percentage.dart';

class AlomathPage extends StatefulWidget {
  const AlomathPage({Key? key}) : super(key: key);

  @override
  _AlomathPageState createState() => _AlomathPageState();
}

class _AlomathPageState extends State<AlomathPage> {
  WebViewController controller = WebViewController();

  bool internetConnexionAvailable = true;

  @override
  void initState() {
    super.initState();
  }

  void autoconnect(String url, SharedPreferences prefs) async {
    final usernameAlomath = prefs.getString("usernameAlomath");
    final pwdAlomath = prefs.getString("pwdAlomath");
    final autoconnexionAlomath = prefs.getBool("autoconnexionAlomath");

    if(autoconnexionAlomath != true) return;

    if(url.startsWith("https://alomath.fr/connexion.php")) {
      await justWait(200);
      controller.runJavaScript(
          "document.querySelector('input[name=\"pseudoconnect\"]').value = \"$usernameAlomath\""
      );
      controller.runJavaScript(
          "document.querySelector('input[name=\"passwordconnect\"]').value = \"${Encrypter.decrypt(pwdAlomath)}\""
      );
      await justWait(200);
      controller.runJavaScript(
          "document.querySelector('button.submit').click()"
      );
    }
  }

  Future<void> getPrefsInstance() async {
    internetConnexionAvailable = await checkInternetConnection();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            autoconnect(url, prefs);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("https://alomath.fr/connexion.php"));
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
          future: getPrefsInstance(),
          builder: (context, snapshot) {
            if (internetConnexionAvailable) {
              return WebViewWidget(controller: controller);
            }
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      color: Colors.white,
                      size: getPercentage(context, "w15"),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Aucune connexion internet",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FeixenBold",
                          fontSize: getPercentage(context, "w10")),
                    ),
                  ],
                )
            );
          },
        )
      ),
    );
  }
}