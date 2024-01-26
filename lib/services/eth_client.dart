import 'dart:convert';

import 'package:foxbit_tracking_web3_flutter/home/domain/model/transaction_log.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class EthClient {
  late Web3Client ethClient;
  final String rpcUrl =
      'https://mainnet.infura.io/v3/ea9b34aac1524774be506054bd3b8984';

  void initializeClient() {
    final httpClient = http.Client();
    ethClient = Web3Client(rpcUrl, httpClient);
  }

  Future<EtherAmount> getBalance(EthereumAddress address) async {
    EtherAmount balance = await ethClient.getBalance(address);
    return balance;
  }

  Future<List<dynamic>> fetchLogs(String walletAddress) async {
    const String apiKey = 'UDMXDHKZYVSZI3R97KWAHBQFW3BV7AV3W1';
    const String apiUrl = 'https://api.etherscan.io/api';

    final response = await http.get(
      Uri.parse('$apiUrl?module=logs&action=getLogs'
          '&address=$walletAddress'
          '&fromBlock=12878196'
          '&toBlock=12878196'
          '&page=1'
          '&offset=1000'
          '&apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      List<TransactionLog> transactionLogs = [];
      Map<String, dynamic> data = json.decode(response.body);
      for (var item in data['result']) {
        transactionLogs.add(TransactionLog.fromJson(item));
      }
      return transactionLogs;
    } else {
      throw Exception('Falha ao carregar os logs');
    }
  }
}
