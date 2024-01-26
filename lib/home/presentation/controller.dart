import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:foxbit_tracking_web3_flutter/home/data/repository/eth_repository.dart';
import 'package:foxbit_tracking_web3_flutter/home/data/repository/local_storage_repository.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/model/transaction_model.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/model/local_wallet.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/usecase/delete_local_wallet_usecase.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/usecase/get_eth_balance_usecase.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/usecase/get_eth_transactions_usecase.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/usecase/get_multiple_wallets_usecase.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/usecase/save_wallet_usecase.dart';
import 'package:foxbit_tracking_web3_flutter/services/btc_client.dart';
import 'package:web3dart/web3dart.dart';

class AppController {
  static AppController? _instance;
  AppController._();

  static AppController get instance {
    _instance ??= AppController._();
    // BTCClient().fetchTransactions("bc1qcueszthdstu99s2vtrlpz9melrhv208cre4xg9");
    return _instance!;
  }

  final List<TransactionModel> transactions = [];
  List<TransactionInformation> transactionsInfo = [];
  late TransactionModel transaction;
  late List<LocalWallet> savedWallets;

  bool isLoading = true;

  Future<void> getWalletInfo(String address) async {
    await getBalance(address);
    await getTransactions(address);

    isLoading = false;
  }

  Future<EtherAmount> getBalance(String address) async {
    final getBalanceusecase = GetEthBalanceUsecase(
        repository: EthRepository(), walletAddress: address);

    final amount = await getBalanceusecase.call();

    transaction = TransactionModel(
        hash: address, coinName: 'Eth', balance: amount.getInWei);
    return amount;
  }

  Future<void> getTransactions(String address) async {
    final getTransactionUsecase = GetEthTransactionsUsecase(
        repository: EthRepository(), walletAddress: address);
    transactionsInfo = await getTransactionUsecase.call();
  }

  void backPage(BuildContext context) {
    isLoading = true;
    Navigator.of(context).pop();
  }

  Future<void> registerWallet(
      String address, String name, WalletType type) async {
    await SaveWalletUsecase(repository: LocalStorageRepository())
        .call(LocalWallet(
      walletName: name,
      walletAddress: address,
      type: type,
    ));
  }

  String weiToEther(BigInt weiAmount) {
    final double etherValue = weiAmount / BigInt.from(1000000000000000000);

    return '${Decimal.parse(etherValue.toString()).truncate(scale: 9).toString()} eth';
  }

  Future<List<LocalWallet>> getLocalWallets() async {
    isLoading = true;
    savedWallets =
        await GetAllWalletsUsecase(repository: LocalStorageRepository()).call();
    isLoading = false;
    return savedWallets;
  }

  void deleteWallet(String address) async {
    await DeleteWalletUsecase(repository: LocalStorageRepository())
        .call(address)
        .then((value) => getLocalWallets());
  }

  String formattingAddress(String address) {
    return address.replaceRange(7, 36, '...');
  }

  String? validator(String text) {
    if (text.isEmpty) {
      return 'Campo vazio';
    }
    if (text.length < 42) {
      return 'Falta caracteres';
    }
    if (text.length > 42) {
      return 'Caracteres demais';
    }
    return null;
  }
}
