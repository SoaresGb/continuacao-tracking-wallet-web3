import 'package:foxbit_tracking_web3_flutter/home/domain/repository/eth_repository.dart';
import 'package:web3dart/web3dart.dart';

class GetEthTransactionsUsecase {
  final IEthRepository _repository;
  final String walletAddress;
  GetEthTransactionsUsecase(
      {required IEthRepository repository, required this.walletAddress})
      : _repository = repository;

  Future<List<TransactionInformation>> call() async {
    List<TransactionInformation> transactionsDetails = [];
    try {
      final transactionLogs = await _repository.fetchLogs(walletAddress);

      for (var transactionLog in transactionLogs) {
        TransactionInformation? transactionInformation =
            await _repository.getHashDetails(transactionLog.hash);
        if (transactionInformation != null) {
          transactionsDetails.add(transactionInformation);
        }
      }
      return transactionsDetails;
    } catch (e) {
      throw Exception('Error Loading Transactions');
    }
  }
}
