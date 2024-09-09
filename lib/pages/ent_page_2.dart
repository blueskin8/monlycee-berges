import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';

class ENTPage extends StatefulWidget {
  const ENTPage({Key? key}) : super(key: key);

  @override
  State<ENTPage> createState() => _ENTPageState();
}

class _ENTPageState extends State<ENTPage> {
  late InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    await FlutterDownloader.initialize(debug: true);
    await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon lycée",
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: const Color(0xff1e202b),
        body: FutureBuilder(
          future: requestPermissions(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              // Afficher un indicateur de chargement pendant l'initialisation
              return const Center(child: CircularProgressIndicator());
            }
            return InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri("https://aristide-berges.ent.auvergnerhonealpes.fr/sg.do?PROC=PAGE_ACCUEIL")
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  cacheEnabled: true,
                  javaScriptEnabled: true,
                  useOnDownloadStart: true,
                  allowUniversalAccessFromFileURLs: true,
                  allowFileAccessFromFileURLs: true,
                ),
              ),
              onWebViewCreated: (controller) {
                webView = controller;
              },
              onDownloadStartRequest: (controller, urlRequest) async {
                String url = urlRequest.toString();
                debugPrint("onDownloadStart $url");
                final taskId = await FlutterDownloader.enqueue(
                  url: url,
                  savedDir: "/storage/emulated/0/Download",
                  showNotification: true,
                  openFileFromNotification: true,
                );
              },
            );
          },
        ),
      ),
    );
  }
}