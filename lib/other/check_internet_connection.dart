import 'dart:io';

Future<bool> checkInternetConnection() async {
  bool a = false;
  try {
    final result = await InternetAddress.lookup("google.fr");
    if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      a = true;
    }
  } on SocketException catch(_) {
    a = false;
  }
  return a;
}