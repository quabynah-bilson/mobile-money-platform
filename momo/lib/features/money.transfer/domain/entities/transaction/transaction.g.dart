// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TransactionCWProxy {
  Transaction amount(double amount);

  Transaction id(String id);

  Transaction recipient(String recipient);

  Transaction reference(String reference);

  Transaction sender(String sender);

  Transaction timestamp(DateTime timestamp);

  Transaction type(String type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Transaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ````
  Transaction call({
    double? amount,
    String? id,
    String? recipient,
    String? reference,
    String? sender,
    DateTime? timestamp,
    String? type,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTransaction.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTransaction.copyWith.fieldName(...)`
class _$TransactionCWProxyImpl implements _$TransactionCWProxy {
  final Transaction _value;

  const _$TransactionCWProxyImpl(this._value);

  @override
  Transaction amount(double amount) => this(amount: amount);

  @override
  Transaction id(String id) => this(id: id);

  @override
  Transaction recipient(String recipient) => this(recipient: recipient);

  @override
  Transaction reference(String reference) => this(reference: reference);

  @override
  Transaction sender(String sender) => this(sender: sender);

  @override
  Transaction timestamp(DateTime timestamp) => this(timestamp: timestamp);

  @override
  Transaction type(String type) => this(type: type);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Transaction(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Transaction(...).copyWith(id: 12, name: "My name")
  /// ````
  Transaction call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? recipient = const $CopyWithPlaceholder(),
    Object? reference = const $CopyWithPlaceholder(),
    Object? sender = const $CopyWithPlaceholder(),
    Object? timestamp = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return Transaction(
      amount: amount == const $CopyWithPlaceholder() || amount == null
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as double,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      recipient: recipient == const $CopyWithPlaceholder() || recipient == null
          ? _value.recipient
          // ignore: cast_nullable_to_non_nullable
          : recipient as String,
      reference: reference == const $CopyWithPlaceholder() || reference == null
          ? _value.reference
          // ignore: cast_nullable_to_non_nullable
          : reference as String,
      sender: sender == const $CopyWithPlaceholder() || sender == null
          ? _value.sender
          // ignore: cast_nullable_to_non_nullable
          : sender as String,
      timestamp: timestamp == const $CopyWithPlaceholder() || timestamp == null
          ? _value.timestamp
          // ignore: cast_nullable_to_non_nullable
          : timestamp as DateTime,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String,
    );
  }
}

extension $TransactionCopyWith on Transaction {
  /// Returns a callable class that can be used as follows: `instanceOfTransaction.copyWith(...)` or like so:`instanceOfTransaction.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TransactionCWProxy get copyWith => _$TransactionCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as String,
      type: json['transaction_type'] as String,
      sender: json['sender'] as String,
      recipient: json['recipient'] as String,
      amount: (json['amount'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      reference: json['reference'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transaction_type': instance.type,
      'sender': instance.sender,
      'recipient': instance.recipient,
      'amount': instance.amount,
      'timestamp': instance.timestamp.toIso8601String(),
      'reference': instance.reference,
    };
