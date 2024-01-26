import 'package:http/http.dart' as http;

class EthDatasource {
  final String etherScanApiKey = 'UDMXDHKZYVSZI3R97KWAHBQFW3BV7AV3W1';
  final String etherScanApiUrl = 'https://api.etherscan.io/api';

  Future<http.Response> getWalletTransactions(String walletAddress) async {
    return await http.get(
      Uri.parse('$etherScanApiUrl?module=account&action=txlist'
          '&address=$walletAddress'
          '&startblock=0'
          '&endblock=99999999'
          '&page=1'
          '&offset=30'
          '&sort=asc'
          '&apikey=$etherScanApiKey'),
    );
  }
}
