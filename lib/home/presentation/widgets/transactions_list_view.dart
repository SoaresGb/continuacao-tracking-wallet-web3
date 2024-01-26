import 'package:flutter/material.dart';
import 'package:foxbit_tracking_web3_flutter/home/presentation/widgets/transaction_list_tile.dart';
import 'package:web3dart/web3dart.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView(
      {super.key, required this.transactions, required this.wallet});

  final List<TransactionInformation> transactions;
  final String wallet;

  @override
  State<TransactionListView> createState() => _TransactionState();
}

class _TransactionState extends State<TransactionListView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              'Transactions (${widget.transactions.length}):',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(height: 2),
              ),
              itemCount: widget.transactions.length,
              itemBuilder: (context, index) {
                return TransactionListTile(
                  transaction: widget.transactions[index],
                  wallet: widget.wallet,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
