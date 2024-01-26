import 'package:foxbit_tracking_web3_flutter/home/domain/repository/eth_repository.dart';
import 'package:web3dart/web3dart.dart';

class GetEthBalanceUsecase {
  GetEthBalanceUsecase({
    required IEthRepository repository,
    required this.walletAddress,
  }) : _repository = repository;

  final IEthRepository _repository;
  final String walletAddress;

  Future<EtherAmount> call() async {
    try {
      final balance = await _repository.getBalance(walletAddress);
      return balance;
    } catch (e) {
      throw Exception('Error Loading Balance');
    }
  }
}
