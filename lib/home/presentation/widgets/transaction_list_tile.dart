import 'package:flutter/material.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/controller.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:web3dart/web3dart.dart';


class TransactionListTile extends StatelessWidget {
  const TransactionListTile({super.key, required this.transaction, required this.wallet});

  final TransactionInformation transaction;
  final String wallet;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(AppController.instance.formattingAddress(transaction.from.toString()), style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Value:', AppController.instance.weiToEther(transaction.value.getInWei)),
            _buildRow('Gas price:', AppController.instance.weiToEther(transaction.gasPrice.getInWei)),
          ],
        ),
        leading : ScalableImageWidget.fromSISource(
          si: ScalableImageSource.fromSvgHttpUrl(
              Uri.parse('https://assets.debank.com/static/media/eth.47c40f70.svg'))
        ),
        trailing: wallet == transaction.from.hex ? const Column(
          children: [
            Icon(Icons.arrow_back),
            Text("Received")
          ],
        ) : const Column(
          children: [
            Icon(Icons.arrow_forward),
            Text("  Sent  ")
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
        Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
      ],
    );
  }

  String formattingValues(BigInt value, double decimal) {
    return '${value.toString()},${decimal.toString().substring(0, 6)}';
  }

}