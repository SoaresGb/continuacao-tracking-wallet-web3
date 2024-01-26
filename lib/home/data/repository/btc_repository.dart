import 'package:foxbit_tracking_web3_flutter/home/data/data_sources/btc_datasource.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/model/transaction_log.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/repository/btc_repository.dart';
import 'dart:convert';

class BTCRepository implements IBTCRepository {
  final BTCDatasource datasource;

  BTCRepository({required this.datasource});
  @override
  Future<List<TransactionLog>> fetchLogs(String walletAddress) async {
    final response = await datasource.getWalletTransactions(walletAddress);

    if (response.statusCode == 200) {
      List<TransactionLog> transactionLogs = [];

      for (var item in json.decode(response.body)['items']) {
        transactionLogs.add(TransactionLog.fromBTCJson(item));
      }
      return transactionLogs;
    } else {
      throw Exception('Failed to load logs');
    }
  }
}
