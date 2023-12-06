import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:monlycee/other/just_wait.dart';

class TurboselfPage extends StatefulWidget {
  const TurboselfPage({Key? key}) : super(key: key);

  @override
  _TurboselfPageState createState() => _TurboselfPageState();
}

class _TurboselfPageState extends State<TurboselfPage> {
  WebViewController controller = WebViewController();

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
      controller.runJavaScript("document.querySelector('#ctl00_cntForm_txtMotDePasse').value = \"$pwdSelf\"");
      controller.runJavaScript("document.querySelector('#ctl00_cntForm_chkRememberMe').checked = \"checked\"");
      await justWait(200);
      controller.runJavaScript("document.querySelector('#ctl00_cntForm_btnConnexion').click()");
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
      ..loadRequest(Uri.parse("https://espacenumerique.turbo-self.com/ReserverRepas.aspx"));
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