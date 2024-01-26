class TransactionModel {
  
  TransactionModel({required this.hash, required this.coinName, required this.balance});

  final String hash;
  final String coinName;
  final BigInt balance;

  factory TransactionModel.fromJsonEther(String hash, String coinName, BigInt amount) {
    return TransactionModel(
      hash: hash,
      coinName: coinName,
      balance: amount,
    );
  }


  get formatedHash => hash.replaceRange(7, 35, '...');

  @override
  String toString() {
    
    return 'WalletAddress: $hash | coinName: $coinName | balance: $balance';
  }
}