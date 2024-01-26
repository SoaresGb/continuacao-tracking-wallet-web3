import 'package:foxbit_tracking_web3_flutter/home/domain/model/local_wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDT {
  LocalStorageDT({required this.localStorage});
  final Future<SharedPreferences> localStorage;
  final String walletsCollection = "wallets";
  Future<void> saveWallet({required LocalWallet wallet}) async {
    try {
      final preferences = await localStorage;
      final wallets = preferences.getStringList(walletsCollection);
      if (wallets == null) {
        preferences.setStringList(walletsCollection, [wallet.toLocalStorage()]);
      } else {
        wallets.add(wallet.toLocalStorage());
        preferences.setStringList(walletsCollection, wallets);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<LocalWallet>?> getAllWallets() async {
    try {
      final preferences = await localStorage;
      final wallets = preferences.getStringList(walletsCollection);
      final List<LocalWallet> decoded = [];
      if (wallets == null) {
        return null;
      }
      for (String wallet in wallets) {
        decoded.add(LocalWallet.fromLocalStorage(wallet));
      }
      return decoded;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteWallet(String walletAddress) async {
    try {
      final preferences = await localStorage;
      final wallets = preferences.getStringList(walletsCollection);
      if (wallets != null) {
        for (int i = 0; i < wallets.length; i++) {
          LocalWallet localWallet = LocalWallet.fromLocalStorage(wallets[i]);
          if (localWallet.walletAddress == walletAddress) {
            wallets.removeAt(i);
            break;
          }
        }
        preferences.setStringList(walletsCollection, wallets);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
