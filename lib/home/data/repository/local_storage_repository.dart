import 'package:foxbit_tracking_web3_flutter/home/data/data_sources/local_storage_datasource.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/model/local_wallet.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/repository/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository implements ILocalStorageRepository {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Future<List<LocalWallet>> getAllWallets() async {
    final dt = LocalStorageDT(localStorage: prefs);
    final wallets = await dt.getAllWallets();
    return wallets ?? [];
  }

  @override
  Future<void> saveWallet(LocalWallet wallet) async {
    final dt = LocalStorageDT(localStorage: prefs);
    await dt.saveWallet(wallet: wallet);
  }

  @override
  Future<void> deleteWallet(String walletAddress) async {
    final dt = LocalStorageDT(localStorage: prefs);
    await dt.deleteWallet(walletAddress);
  }
}
