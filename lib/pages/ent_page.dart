import 'package:flutter/material.dart';
import 'package:monlycee/other/check_internet_connection.dart';
import 'package:monlycee/other/crypter.dart';
import 'package:monlycee/other/just_wait.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../other/get_percentage.dart';

class ENTPage extends StatefulWidget {
  const ENTPage({Key? key}) : super(key: key);

  @override
  _ENTPageState createState() => _ENTPageState();
}

class _ENTPageState extends State<ENTPage> {
  WebViewController controller = WebViewController();

  bool internetConnexionAvailable = true;

  @override
  void initState() {
    super.initState();
  }

  void autoconnect(String url, SharedPreferences prefs) async {
    final usernameENT = prefs.get("usernameENT");
    final pwdENT = prefs.get("pwdENT");
    final autoconnexionENT = prefs.getBool("autoconnexionENT");

    if (autoconnexionENT != true) return;

    if (url.startsWith(
        "https://cas.ent.auvergnerhonealpes.fr/login?service=https%3A%2F%2Faristide-berges.ent.auvergnerhonealpes.fr")) {
      await justWait(200);
      controller.runJavaScript(
        "document.querySelector('#idp-EDU').checked = 'true'",
      );
      controller.runJavaScript(
        "document.querySelector('input#button-submit').click()",
      );
    }

    if (url.startsWith(
        "https://educonnect.education.gouv.fr/idp/profile/SAML2/POST/SSO")) {
      await justWait(200);
      controller.runJavaScript(
        "document.querySelector('button#bouton_eleve').click()",
      );
      await justWait(500);
      controller.runJavaScript(
        "document.querySelector('#username').value = \"$usernameENT\"",
      );
      controller.runJavaScript(
        "document.querySelector('#password').value = \"${Encrypter.decrypt(pwdENT)}\"",
      );
      await justWait(500);
      controller.runJavaScript(
        "document.querySelector('#bouton_valider').click()",
      );
    }

    if (url.startsWith(
        "https://cas.ent.auvergnerhonealpes.fr/saml/SAMLAssertionConsumer")) {
      await justWait(200);
      controller.runJavaScript(
        "document.querySelector('div.msg__content > p.p-like > strong > a').click()",
      );
    }
  }

  Future<void> getPrefsInstance() async {
    internetConnexionAvailable = await checkInternetConnection();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await Permission.storage.request();

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
      ..loadRequest(Uri.parse(
          "https://aristide-berges.ent.auvergnerhonealpes.fr/sg.do?PROC=PAGE_ACCUEIL"));
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
                ));
          },
        ),
      ),
    );
  }
}
