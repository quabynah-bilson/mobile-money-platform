import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

enum TransactionType {
  transfer,
  cashout,
  payment,
}

@CopyWith()
@JsonSerializable()
class Transaction {
  final String id;
  @JsonKey(name: 'transaction_type')
  final String type;
  final String sender;
  final String recipient;
  final double amount;
  final DateTime timestamp;
  final String reference;

  const Transaction({
    required this.id,
    required this.type,
    required this.sender,
    required this.recipient,
    required this.amount,
    required this.timestamp,
    required this.reference,
  });

  factory Transaction.fromJson(json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @override
  String toString() => toJson().toString();
}
