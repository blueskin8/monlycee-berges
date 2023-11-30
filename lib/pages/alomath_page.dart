import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:monlycee/components/bottom_nav_bar.dart';

class AlomathPage extends StatelessWidget {
  final WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse("https://alomath.fr/connexion.php"));

  AlomathPage({Key? key}) : super(key: key);

  Future<void> getPrefsInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usernameAlomath = prefs.get("usernameAlomath");
    final pwdAlomath = prefs.get("pwdAlomath");
    final autoconnexionAlomath = prefs.getBool("autoconnexionAlomath");
    if(autoconnexionAlomath == true) {
      Future.delayed(const Duration(seconds: 2), () => {
        controller.runJavaScript(
            "document.querySelector('input[name=\"pseudoconnect\"]').value = \"$usernameAlomath\""
        ),
        controller.runJavaScript(
            "document.querySelector('input[name=\"passwordconnect\"]').value = \"$pwdAlomath\""
        ),
        Future.delayed(const Duration(seconds: 1), () => {
          controller.runJavaScript(
          "document.querySelector('button.submit').click()"
          )
        })
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon lycée",
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: const Color(0xff2a3961),
        bottomNavigationBar: const BottomNavBar(),
        body: FutureBuilder(
          future: getPrefsInstance(),
          builder: (context, snapshot) {
            return WebViewWidget(controller: controller);
          },
        ),
      ),
    );
  }
}