import 'package:encrypt/encrypt.dart' as crypt;

const String cryptKey = "EkfVpSickYlC8XvTTO1kG7faX12PVU1I9fWh6ZDJu1eK7phnAx6+c407axgL7fuY";
const String initalizationVector = "qCNcgZazWfkpyarL";

String get(value) {
  if(value == "cryptkey") {
    final key = crypt.Key.fromUtf8("BhmKdD8HHtYnvyhU0gsvQgAshjtyGkuv");
    final iv = crypt.IV.fromUtf8(initalizationVector);
    final encrypter = crypt.Encrypter(crypt.AES(key));

    final decrypted = encrypter.decrypt(crypt.Encrypted.fromBase64("EkfVpSickYlC8XvTTO1kG7faX12PVU1I9fWh6ZDJu1eK7phnAx6+c407axgL7fuY"), iv: iv);
    return decrypted;
  }
  if(value == "iv") {
    return initalizationVector;
  }
  throw "The value $value doesn't exist";
}