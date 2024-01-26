import 'package:flutter/material.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/controller.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/loading_page.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/widgets/new_wallet_form.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/widgets/wallet_list_tile.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  WalletPageState createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  final controller = AppController.instance;

  @override
  void initState() {
    AppController.instance.getLocalWallets().then((value) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Builder(
        builder: (_) {
          if (controller.isLoading) {
            return Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: const LoadingWidget(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: MediaQuery.of(context).size.width * 0.13,
                ),
                child: const Text(
                  'Wallets',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: _transactionList(),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  bottom: MediaQuery.of(context).size.height * 0.1,
                ),
                child: NewWallet(
                  controller: controller,
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _transactionList() => ListView.separated(
        separatorBuilder: (context, index) => const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(height: 2),
        ),
        itemCount: controller.savedWallets.length,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1,
        ),
        itemBuilder: (context, index) => Dismissible(
          key: Key(controller.savedWallets[index].walletAddress),
          onDismissed: (direction) async {
            final addressToRemove =
                controller.savedWallets[index].walletAddress;

            setState(() {
              controller.savedWallets.clear();
              controller.deleteWallet(addressToRemove);
            });
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          child: WalletListTile(
            wallet: controller.savedWallets[index],
          ),
        ),
      );
}
