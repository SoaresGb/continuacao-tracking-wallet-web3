import 'package:foxbit_tracking_web3_flutter/home/domain/model/local_wallet.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/repository/local_storage_repository.dart';

class SaveWalletUsecase {
  SaveWalletUsecase({
    required ILocalStorageRepository repository,
  }) : _repository = repository;

  final ILocalStorageRepository _repository;

  Future<void> call(LocalWallet wallet) async {
    return await _repository.saveWallet(wallet);
  }
}
