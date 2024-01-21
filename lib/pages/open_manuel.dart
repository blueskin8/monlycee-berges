import 'package:flutter/material.dart';
import 'package:monlycee/other/check_internet_connection.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';

class OpenManuelPage extends StatelessWidget {
  final String url;
  OpenManuelPage({Key? key, required this.url}) : super(key: key);

  bool internetConnexionAvailable = true;

  WebViewController controller = WebViewController();

  Future<void> getPrefsInstance() async {
    internetConnexionAvailable = await checkInternetConnection();
    controller = WebViewController()
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
      ..loadRequest(Uri.parse(url));
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
        ),
      ),
    );
  }
}
