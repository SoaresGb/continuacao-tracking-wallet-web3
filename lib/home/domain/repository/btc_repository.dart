import 'package:foxbit_tracking_web3_flutter/home/domain/model/transaction_log.dart';

abstract class IBTCRepository {
  Future<List<TransactionLog>> fetchLogs(String walletAddress);
}
