import 'package:flutter/material.dart';
import 'package:foxbit_tracking_web3_flutter/home/domain/model/local_wallet.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/controller.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/view_wallet_balance_page.dart';
import 'package:web3dart/web3dart.dart';

class WalletListTile extends StatelessWidget {
  const WalletListTile({super.key, required this.wallet});

  final LocalWallet wallet;

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ViewWalletBalancePage(
                address: wallet.walletAddress,
              ),
            ),
          ),
          title: Text(
            wallet.walletName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: FutureBuilder<EtherAmount>(
            future: AppController.instance.getBalance(wallet.walletAddress),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 25,
                  width: 25,
                  child: Image.network(
                    'https://media.tenor.com/QMfaVm3kNy0AAAAi/moneda-girando-spinning.gif',
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('Error');
              } else {
                return Text(
                  'eth: ${AppController.instance.weiToEther(snapshot.data!.getInWei)}',
                  style: const TextStyle(fontSize: 16),
                );
              }
            },
          ),
        ),
      );
}
