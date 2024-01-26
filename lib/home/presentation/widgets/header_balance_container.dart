import 'package:flutter/material.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/controller.dart';

class HeaderBalanceContainer extends StatelessWidget {
  const HeaderBalanceContainer({super.key, required this.coinName, required this.userBalance});

  final String coinName;
  final BigInt userBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Balance',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('$coinName: ${AppController.instance.weiToEther(userBalance)}'),
                      ],
                    ),
                  ],
                ),
              );
  }
}