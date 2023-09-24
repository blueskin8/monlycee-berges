import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ENTPage extends StatelessWidget {
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
    ..loadRequest(Uri.parse("https://aristide-berges.ent.auvergnerhonealpes.fr/sg.do?PROC=PAGE_ACCUEIL"));

  ENTPage({Key? key}) : super(key: key);

  Future<void> getPrefsInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final usernameENT = prefs.get("usernameENT");
    final pwdENT = prefs.get("pwdENT");


    Future.delayed(const Duration(seconds: 1), () =>
    {
      controller.runJavaScript(
          "document.querySelector('input#button-submit').click()"),
      Future.delayed(const Duration(seconds: 1), () =>
      {
        controller.runJavaScript(
            "document.querySelector('button#bouton_eleve').click()"),
        Future.delayed(const Duration(seconds: 1), () =>
        {
          controller.runJavaScript(
              "document.querySelector('#username').value = \"$usernameENT\""),
          controller.runJavaScript(
              "document.querySelector('#password').value = \"$pwdENT\""),
          Future.delayed(const Duration(seconds: 1), () =>
          {
            controller.runJavaScript(
                "document.querySelector('#bouton_valider').click()"),
            Future.delayed(const Duration(seconds: 1), () =>
            {
              controller.runJavaScript(
                  "document.querySelector('div.msg__content > p.p-like > strong > a').click()")
            })
          })
        })
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPrefsInstance(),
      builder: (context, snapshot) {
        return Scaffold(
          body: WebViewWidget(controller: controller),
        );
      },
    );
  }
}
