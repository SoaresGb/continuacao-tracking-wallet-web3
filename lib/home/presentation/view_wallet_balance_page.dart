import 'package:flutter/material.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/controller.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/loading_page.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/widgets/header_balance_container.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/widgets/transactions_list_view.dart';

class ViewWalletBalancePage extends StatefulWidget {
  const ViewWalletBalancePage({super.key, required this.address});

  final String address;

  @override
  State<ViewWalletBalancePage> createState() => _ViewWalletBalancePageState();
}

class _ViewWalletBalancePageState extends State<ViewWalletBalancePage> {
  final controller = AppController.instance;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        controller.isLoading = true;
      });
      controller.getWalletInfo(widget.address).then((value) => setState(() {}));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => controller.backPage(context),
          ),
        ),
        body: controller.isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: const LoadingWidget())
            : Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
                child: Column(
                  children: <Widget>[
                    HeaderBalanceContainer(
                        coinName: controller.transaction.coinName,
                        userBalance: controller.transaction.balance),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Divider(height: 2),
                    ),
                    TransactionListView(
                        transactions: controller.transactionsInfo,
                        wallet: widget.address),
                  ],
                ),
              ));
  }
}
