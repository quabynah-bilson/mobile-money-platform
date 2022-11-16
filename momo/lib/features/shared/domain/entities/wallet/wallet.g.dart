// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WalletCWProxy {
  Wallet balance(double balance);

  Wallet hashedPhone(String hashedPhone);

  Wallet holder(String holder);

  Wallet id(String id);

  Wallet phone(String phone);

  Wallet provider(String provider);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Wallet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Wallet(...).copyWith(id: 12, name: "My name")
  /// ````
  Wallet call({
    double? balance,
    String? hashedPhone,
    String? holder,
    String? id,
    String? phone,
    String? provider,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWallet.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWallet.copyWith.fieldName(...)`
class _$WalletCWProxyImpl implements _$WalletCWProxy {
  final Wallet _value;

  const _$WalletCWProxyImpl(this._value);

  @override
  Wallet balance(double balance) => this(balance: balance);

  @override
  Wallet hashedPhone(String hashedPhone) => this(hashedPhone: hashedPhone);

  @override
  Wallet holder(String holder) => this(holder: holder);

  @override
  Wallet id(String id) => this(id: id);

  @override
  Wallet phone(String phone) => this(phone: phone);

  @override
  Wallet provider(String provider) => this(provider: provider);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Wallet(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Wallet(...).copyWith(id: 12, name: "My name")
  /// ````
  Wallet call({
    Object? balance = const $CopyWithPlaceholder(),
    Object? hashedPhone = const $CopyWithPlaceholder(),
    Object? holder = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? provider = const $CopyWithPlaceholder(),
  }) {
    return Wallet(
      balance: balance == const $CopyWithPlaceholder() || balance == null
          ? _value.balance
          // ignore: cast_nullable_to_non_nullable
          : balance as double,
      hashedPhone:
          hashedPhone == const $CopyWithPlaceholder() || hashedPhone == null
              ? _value.hashedPhone
              // ignore: cast_nullable_to_non_nullable
              : hashedPhone as String,
      holder: holder == const $CopyWithPlaceholder() || holder == null
          ? _value.holder
          // ignore: cast_nullable_to_non_nullable
          : holder as String,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      phone: phone == const $CopyWithPlaceholder() || phone == null
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
      provider: provider == const $CopyWithPlaceholder() || provider == null
          ? _value.provider
          // ignore: cast_nullable_to_non_nullable
          : provider as String,
    );
  }
}

extension $WalletCopyWith on Wallet {
  /// Returns a callable class that can be used as follows: `instanceOfWallet.copyWith(...)` or like so:`instanceOfWallet.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WalletCWProxy get copyWith => _$WalletCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      id: json['id'] as String,
      holder: json['holder'] as String,
      provider: json['provider'] as String,
      phone: json['phone'] as String,
      hashedPhone: json['hashedPhone'] as String,
      balance: (json['balance'] as num).toDouble(),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'holder': instance.holder,
      'provider': instance.provider,
      'phone': instance.phone,
      'hashedPhone': instance.hashedPhone,
      'balance': instance.balance,
    };
