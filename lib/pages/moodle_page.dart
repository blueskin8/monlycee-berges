import 'package:flutter/material.dart';
import 'package:monlycee/other/check_internet_connection.dart';
import 'package:monlycee/other/crypter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:monlycee/other/just_wait.dart';

import '../other/get_percentage.dart';

class MoodlePage extends StatefulWidget {
  const MoodlePage({Key? key}) : super(key: key);

  @override
  _MoodlePageState createState() => _MoodlePageState();
}

class _MoodlePageState extends State<MoodlePage> {
  WebViewController controller = WebViewController();

  bool internetConnexionAvailable = true;

  @override
  void initState() {
    super.initState();
  }

  void autoconnect(String url, SharedPreferences prefs) async {
    final usernameSelf = prefs.getString("usernameSelf");
    final pwdSelf = prefs.getString("pwdSelf");
    final autoconnexionSelf = prefs.getBool("autoconnexionSelf");

    if(autoconnexionSelf != true) return;

    if(url.startsWith("https://espacenumerique.turbo-self.com/Connexion.aspx")) {
      await justWait(200);
      controller.runJavaScript("document.querySelector('#ctl00_cntForm_txtLogin').value = \"$usernameSelf\"");
      controller.runJavaScript("document.querySelector('#ctl00_cntForm_txtMotDePasse').value = \"${Encrypter.decrypt(pwdSelf)}\"");
      controller.runJavaScript("document.querySelector('#ctl00_cntForm_chkRememberMe').checked = \"checked\"");
      await justWait(200);
      controller.runJavaScript("document.querySelector('#ctl00_cntForm_btnConnexion').click()");
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
      ..loadRequest(Uri.parse("https://espacenumerique.turbo-self.com/ReserverRepas.aspx"));
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
                )
            );
          },
        ),
      ),
    );
  }
}