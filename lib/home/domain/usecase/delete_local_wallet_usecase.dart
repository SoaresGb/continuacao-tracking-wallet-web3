import 'package:foxbit_tracking_web3_flutter/home/domain/repository/local_storage_repository.dart';

class DeleteWalletUsecase {
  DeleteWalletUsecase({
    required ILocalStorageRepository repository,
  }) : _repository = repository;

  final ILocalStorageRepository _repository;

  Future<void> call(String walletAddress) async {
    return await _repository.deleteWallet(walletAddress);
  }
}
