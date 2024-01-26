import 'dart:convert';

class LocalWallet {
  String walletName;
  String walletAddress;
  WalletType type;

  LocalWallet({
    required this.walletName,
    required this.walletAddress,
    required this.type,
  });

  factory LocalWallet.fromLocalStorage(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return LocalWallet(
      walletName: jsonMap['walletName'],
      walletAddress: jsonMap['walletAddress'],
      type: jsonMap['type'],
    );
  }

  String toLocalStorage() {
    final Map<String, String> jsonMap = {
      'walletName': walletName,
      'walletAddress': walletAddress,
      'type': type.field,
    };
    return jsonEncode(jsonMap);
  }
}

enum WalletType {
  btc("Bitcoin"),
  eth("Etherium");

  final String field;

  const WalletType(this.field);
}
