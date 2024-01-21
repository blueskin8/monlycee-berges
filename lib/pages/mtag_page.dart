import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:monlycee/components/bottom_nav_bar.dart';

import '../other/check_internet_connection.dart';
import '../other/get_percentage.dart';
//
// class MTagPage extends StatelessWidget {
//   final WebViewController controller = WebViewController()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setNavigationDelegate(
//       NavigationDelegate(
//         onProgress: (int progress) {},
//         onPageStarted: (String url) {},
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           return NavigationDecision.navigate;
//         },
//       ),
//     )
//     ..loadRequest(Uri.parse("https://www.tag.fr/8-horaires.htm"));
//
//   MTagPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Mon lycée",
//       darkTheme: ThemeData.dark(),
//       home: Scaffold(
//         backgroundColor: const Color(0xff2a3961),
//         bottomNavigationBar: BottomNavBar(context: context),
//         body: WebViewWidget(controller: controller)
//       ),
//     );
//   }
// }

class MTagPage extends StatefulWidget {
  const MTagPage({Key? key}) : super(key: key);

  @override
  _MTagPageState createState() => _MTagPageState();
}

class _MTagPageState extends State<MTagPage> {
  WebViewController controller = WebViewController()
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

  bool internetConnexionAvailable = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getPrefsInstance() async {
    internetConnexionAvailable = await checkInternetConnection();
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
          )
      ),
    );
  }
}