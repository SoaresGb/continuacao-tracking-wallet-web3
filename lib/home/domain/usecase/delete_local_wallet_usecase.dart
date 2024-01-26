import 'package:foxbit_tracking_web3_flutter/home/domain/repository/local_storage_repository.dart';

class DeleteWalletUsecase {
  final ILocalStorageRepository _repository;
  DeleteWalletUsecase({
    required ILocalStorageRepository repository,
  }) : _repository = repository;

  Future<void> call(String walletAddress) async {
    return await _repository.deleteWallet(walletAddress);
  }
}
