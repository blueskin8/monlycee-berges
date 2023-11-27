import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TurboselfPage extends StatelessWidget {
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
    ..loadRequest(Uri.parse("https://espacenumerique.turbo-self.com/ReserverRepas.aspx"));

  TurboselfPage({Key? key}) : super(key: key);

  Future<void> getPrefsInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usernameSelf = prefs.get("usernameSelf");
    final pwdSelf = prefs.get("pwdSelf");
    final autoconnexionSelf = prefs.getBool("autoconnexionSelf");
    if(autoconnexionSelf == true) {
      Future.delayed(const Duration(seconds: 2), () => {
        controller.runJavaScript("document.querySelector('#ctl00_cntForm_txtLogin').value = \"$usernameSelf\""),
        controller.runJavaScript("document.querySelector('#ctl00_cntForm_txtMotDePasse').value = \"$pwdSelf\""),
        controller.runJavaScript("document.querySelector('#ctl00_cntForm_chkRememberMe').checked = \"checked\""),
        Future.delayed(const Duration(seconds: 1), () => {
          controller.runJavaScript("document.querySelector('#ctl00_cntForm_btnConnexion').click()")
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
        )
      ),
    );
  }
}
