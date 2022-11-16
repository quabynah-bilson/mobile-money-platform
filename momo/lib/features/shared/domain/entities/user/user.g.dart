// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MomoUserCWProxy {
  MomoUser id(String id);

  MomoUser lastLogin(DateTime lastLogin);

  MomoUser name(String name);

  MomoUser network(String network);

  MomoUser phoneNumber(String phoneNumber);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MomoUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MomoUser(...).copyWith(id: 12, name: "My name")
  /// ````
  MomoUser call({
    String? id,
    DateTime? lastLogin,
    String? name,
    String? network,
    String? phoneNumber,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMomoUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMomoUser.copyWith.fieldName(...)`
class _$MomoUserCWProxyImpl implements _$MomoUserCWProxy {
  final MomoUser _value;

  const _$MomoUserCWProxyImpl(this._value);

  @override
  MomoUser id(String id) => this(id: id);

  @override
  MomoUser lastLogin(DateTime lastLogin) => this(lastLogin: lastLogin);

  @override
  MomoUser name(String name) => this(name: name);

  @override
  MomoUser network(String network) => this(network: network);

  @override
  MomoUser phoneNumber(String phoneNumber) => this(phoneNumber: phoneNumber);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MomoUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MomoUser(...).copyWith(id: 12, name: "My name")
  /// ````
  MomoUser call({
    Object? id = const $CopyWithPlaceholder(),
    Object? lastLogin = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? network = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
  }) {
    return MomoUser(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      lastLogin: lastLogin == const $CopyWithPlaceholder() || lastLogin == null
          ? _value.lastLogin
          // ignore: cast_nullable_to_non_nullable
          : lastLogin as DateTime,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      network: network == const $CopyWithPlaceholder() || network == null
          ? _value.network
          // ignore: cast_nullable_to_non_nullable
          : network as String,
      phoneNumber:
          phoneNumber == const $CopyWithPlaceholder() || phoneNumber == null
              ? _value.phoneNumber
              // ignore: cast_nullable_to_non_nullable
              : phoneNumber as String,
    );
  }
}

extension $MomoUserCopyWith on MomoUser {
  /// Returns a callable class that can be used as follows: `instanceOfMomoUser.copyWith(...)` or like so:`instanceOfMomoUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MomoUserCWProxy get copyWith => _$MomoUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomoUser _$MomoUserFromJson(Map<String, dynamic> json) => MomoUser(
      id: json['id'] as String,
      name: json['display_name'] as String,
      phoneNumber: json['phone_number'] as String,
      lastLogin: DateTime.parse(json['last_login'] as String),
      network: json['network_id'] as String,
    );

Map<String, dynamic> _$MomoUserToJson(MomoUser instance) => <String, dynamic>{
      'id': instance.id,
      'display_name': instance.name,
      'phone_number': instance.phoneNumber,
      'last_login': instance.lastLogin.toIso8601String(),
      'network_id': instance.network,
    };
