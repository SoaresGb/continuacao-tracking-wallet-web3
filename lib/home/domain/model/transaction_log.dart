class TransactionLog {

  final String blockNumber;
  final String timeStamp;
  final String hash;
  final String nonce;
  final String blockHash;
  final String transactionIndex;
  final String from;
  final String to;
  final String value;
  final String gas;
  final String gasPrice;
  final String isError;
  final String txReceiptStatus;
  final String input;
  final String contractAddress;
  final String cumulativeGasUsed;
  final String gasUsed;
  final String confirmations;
  final String methodId;
  final String functionName;

  TransactionLog({
    required this.blockNumber,
    required this.timeStamp,
    required this.hash,
    required this.nonce,
    required this.blockHash,
    required this.transactionIndex,
    required this.from,
    required this.to,
    required this.value,
    required this.gas,
    required this.gasPrice,
    required this.isError,
    required this.txReceiptStatus,
    required this.input,
    required this.contractAddress,
    required this.cumulativeGasUsed,
    required this.gasUsed,
    required this.confirmations,
    required this.methodId,
    required this.functionName,
  });

  factory TransactionLog.fromJson(Map<String, dynamic> json) {
    return TransactionLog(
      blockNumber: json['blockNumber'],
      timeStamp: json['timeStamp'],
      hash: json['hash'],
      nonce: json['nonce'],
      blockHash: json['blockHash'],
      transactionIndex: json['transactionIndex'],
      from: json['from'],
      to: json['to'],
      value: json['value'],
      gas: json['gas'],
      gasPrice: json['gasPrice'],
      isError: json['isError'],
      txReceiptStatus: json['txreceipt_status'],
      input: json['input'],
      contractAddress: json['contractAddress'],
      cumulativeGasUsed: json['cumulativeGasUsed'],
      gasUsed: json['gasUsed'],
      confirmations: json['confirmations'],
      methodId: json['methodId'],
      functionName: json['functionName'],
    );
  }

  // get formatedAddress => address.replaceRange(7, 35, '...');

  factory TransactionLog.readable(TransactionLog log) {
    String hexToDecimal(String hexVal) {
      try {
        if (hexVal == '0x') return '0';
        return BigInt.parse(hexVal.replaceFirst('0x', ''), radix: 16)
            .toString();
      } catch (e) {
        return "Error";
      }
    }

    return TransactionLog(
      blockNumber: hexToDecimal(log.blockNumber),
      blockHash: log.blockHash,
      timeStamp: hexToDecimal(log.timeStamp),
      gasPrice: hexToDecimal(log.gasPrice),
      gasUsed: hexToDecimal(log.gasUsed),
      transactionIndex: hexToDecimal(log.transactionIndex),
      hash: log.hash,
      nonce: hexToDecimal(log.nonce),
      from: log.from,
      to: log.to,
      value: hexToDecimal(log.value),
      gas: hexToDecimal(log.gas),
      isError: hexToDecimal(log.isError),
      txReceiptStatus: hexToDecimal(log.txReceiptStatus),
      input: log.input,
      contractAddress: log.contractAddress,
      cumulativeGasUsed: hexToDecimal(log.cumulativeGasUsed),
      confirmations: hexToDecimal(log.confirmations),
      methodId: log.methodId,
      functionName: log.functionName,
    );
  }

  // @override
  // String toString() {
  //   return 'TransactionLog(address: $address, topics: $topics, data: $data, blockNumber: $blockNumber, blockHash: $blockHash, timeStamp: $timeStamp, gasPrice: $gasPrice, gasUsed: $gasUsed, logIndex: $logIndex, transactionHash: $transactionHash, transactionIndex: $transactionIndex)';
  // }
}
