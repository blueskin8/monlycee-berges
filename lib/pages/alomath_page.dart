import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:monlycee/other/just_wait.dart';

class AlomathPage extends StatefulWidget {
  const AlomathPage({Key? key}) : super(key: key);

  @override
  _AlomathPageState createState() => _AlomathPageState();
}

class _AlomathPageState extends State<AlomathPage> {
  WebViewController controller = WebViewController();

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
          "document.querySelector('input[name=\"passwordconnect\"]').value = \"$pwdAlomath\""
      );
      await justWait(200);
      controller.runJavaScript(
          "document.querySelector('button.submit').click()"
      );
    }
  }

  Future<void> getPrefsInstance() async {
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
        bottomNavigationBar: const BottomNavBar(),
        body: FutureBuilder(
          future: getPrefsInstance(),
          builder: (context, snapshot) => WebViewWidget(controller: controller),
        )
      ),
    );
  }
}