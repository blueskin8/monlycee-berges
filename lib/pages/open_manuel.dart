import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:monlycee/other/check_internet_connection.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';

class OpenManuelPage extends StatelessWidget {
  final String url;
  OpenManuelPage({Key? key, required this.url}) : super(key: key);

  bool internetConnexionAvailable = true;

  bool dataEco = false;

  WebViewController controller = WebViewController();

  Future<bool> isConnectedToWifi() async {
    ConnectivityResult connectivityResult = (await Connectivity().checkConnectivity())[0];
    if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getPrefsInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isCoWifi = await isConnectedToWifi();

    if(isCoWifi) {
      dataEco = false;
    } else {
      dataEco = prefs.getBool("dataEco")!;
    }
    if(!dataEco) {
      internetConnexionAvailable = await checkInternetConnection();
    } else {
      internetConnexionAvailable = true;
    }

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
