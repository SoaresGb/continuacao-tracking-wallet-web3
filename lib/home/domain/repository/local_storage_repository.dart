import 'package:foxbit_tracking_web3_flutter/home/domain/model/local_wallet.dart';

abstract class ILocalStorageRepository {
  Future<void> saveWallet(LocalWallet wallet);
  Future<List<LocalWallet>> getAllWallets();
  Future<void> deleteWallet(String walletAddress);
}
