import 'package:foxbit_tracking_web3_flutter/home/domain/repository/eth_repository.dart';
import 'package:web3dart/web3dart.dart';

class GetEthBalanceUsecase {
  final IEthRepository _repository;
  final String walletAddress;
  GetEthBalanceUsecase(
      {required IEthRepository repository, required this.walletAddress})
      : _repository = repository;

  Future<EtherAmount> call() async {
    try {
      final balance = await _repository.getBalance(walletAddress);
      return balance;
    } catch (e) {
      throw Exception('Error Loading Balance');
    }
  }
}
