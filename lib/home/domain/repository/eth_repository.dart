import 'package:foxbit_tracking_web3_flutter/home/domain/model/transaction_log.dart';
import 'package:web3dart/web3dart.dart';

abstract class IEthRepository {
  Future<EtherAmount> getBalance(String walletAddress);
  Future<List<TransactionLog>> fetchLogs(String walletAddress);
  Future<TransactionInformation?> getHashDetails(String hash);
}
