import 'package:foxbit_tracking_web3_flutter/home/domain/model/local_wallet.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/repository/local_storage_repository.dart';

class GetAllWalletsUsecase {
  final ILocalStorageRepository _repository;

  GetAllWalletsUsecase({required ILocalStorageRepository repository})
      : _repository = repository;

  Future<List<LocalWallet>> call() async {
    final wallets = await _repository.getAllWallets();
    return wallets;
  }
}
