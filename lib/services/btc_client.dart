import 'package:http/http.dart' as http;

class BTCClient {
  static const String _covalenthqApiKey = "cqt_rQ3y3Xw84PyfGxqJPM6fWQJDxDgb";

  String _getTransactionsURL(String address) {
    return "https://api.covalenthq.com/v1/cq/covalent/app/bitcoin/transactions/?address=$address";
  }

  Future<void> fetchTransactions(String address) async {
    print('started');
    String endpoint = _getTransactionsURL(address);

    Map<String, String> reqHeaders = {
      'Authorization': 'Bearer $_covalenthqApiKey'
    };
    final response = await http.get(
      Uri.parse(endpoint),
      headers: reqHeaders,
    );
    print(response);
  }
}
