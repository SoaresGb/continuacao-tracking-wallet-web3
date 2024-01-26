import 'dart:convert';

import 'package:foxbit_tracking_web3_flutter/home/data/data_sources/eth_datasource.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/model/transaction_log.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/repository/eth_repository.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class EthRepository implements IEthRepository {
  late Web3Client ethClient;
  final String rpcUrl =
      'https://mainnet.infura.io/v3/ea9b34aac1524774be506054bd3b8984';

  void initializeClient() {
    final httpClient = http.Client();
    ethClient = Web3Client(rpcUrl, httpClient);
  }

  EthRepository() {
    initializeClient();
  }
  @override
  Future<List<TransactionLog>> fetchLogs(String walletAddress) async {
    final response = await EthDatasource().getWalletTransactions(walletAddress);

    if (response.statusCode == 200) {
      List<TransactionLog> transactionLogs = [];
      
      for (var item in json.decode(response.body)['result']) {
        transactionLogs.add(TransactionLog.fromJson(item));
      }
      return transactionLogs;
    } else {
      throw Exception('Failed to load logs');
    }
  }

  @override
  Future<EtherAmount> getBalance(String walletAddress) async {
    EtherAmount balance =
        await ethClient.getBalance(EthereumAddress.fromHex(walletAddress));
    return balance;
  }

  @override
  Future<TransactionInformation?> getHashDetails(String hash) async {
    TransactionInformation? info = await ethClient.getTransactionByHash(hash);
    return info;
  }
}
