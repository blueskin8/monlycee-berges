import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:monlycee/other/check_internet_connection.dart';
import 'package:monlycee/other/get_percentage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';

class OpenManuelPage extends StatefulWidget {
  final String url;
  OpenManuelPage({Key? key, required this.url}) : super(key: key);

  @override
  _OpenManuelPageState createState() => _OpenManuelPageState();
}

class _OpenManuelPageState extends State<OpenManuelPage> {
  bool internetConnexionAvailable = true;
  bool dataEco = false;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    getPrefsInstance();
  }

  Future<void> retryInternet() async {
    internetConnexionAvailable = await checkInternetConnection();
  }

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

    if (isCoWifi) {
      dataEco = false;
    } else {
      dataEco = prefs.getBool("dataEco") ?? false;
    }

    if (!dataEco) {
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
      ..loadRequest(Uri.parse(widget.url));

    setState(() {});
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
                      fontSize: getPercentage(context, "w10"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          retryInternet();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2b2c39)
                      ),
                      child: Text(
                        "Réessayer",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "FeixenVariable",
                            fontSize: getPercentage(context, "w5")
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}