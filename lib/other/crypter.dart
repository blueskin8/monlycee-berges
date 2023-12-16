import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:monlycee/other/env.dart' as env;

class Encrypter {
  static crypt(value) {
    final String cryptKey = env.get("cryptkey");
    final key = encrypt.Key.fromUtf8(cryptKey);
    final iv = encrypt.IV.fromUtf8(env.get("iv"));
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(value, iv: iv);
    return encrypted.base64;
  }

  static decrypt(value) {
    final key = encrypt.Key.fromUtf8(env.get("cryptkey"));
    final iv = encrypt.IV.fromUtf8(env.get("iv"));
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decrypted = encrypter.decrypt64(value, iv: iv);
    return decrypted;
  }
}