import 'dart:convert';

class LocalWallet {
  String walletName;
  String walletAddress;

  LocalWallet({
    required this.walletName,
    required this.walletAddress,
  });

  factory LocalWallet.fromLocalStorage(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return LocalWallet(
      walletName: jsonMap['walletName'],
      walletAddress: jsonMap['walletAddress'],
    );
  }

  String toLocalStorage() {
    final Map<String, String> jsonMap = {
      'walletName': walletName,
      'walletAddress': walletAddress,
    };
    return jsonEncode(jsonMap);
  }
}
