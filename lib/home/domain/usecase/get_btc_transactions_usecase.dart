import 'package:foxbit_tracking_web3_flutter/home/domain/model/transaction_log.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/repository/btc_repository.dart';
import 'package:web3dart/web3dart.dart';

class GetBTCTransactionsUsecase {
  final IBTCRepository _repository;
  final String walletAddress;
  GetBTCTransactionsUsecase(
      {required IBTCRepository repository, required this.walletAddress})
      : _repository = repository;

  Future<List<TransactionLog>> call() async {
    try {
      final transactionLogs = await _repository.fetchLogs(walletAddress);

      return transactionLogs;
    } catch (e) {
      throw Exception('Error Loading Transactions');
    }
  }
}
