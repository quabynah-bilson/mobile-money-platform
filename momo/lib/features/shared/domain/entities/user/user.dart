import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
@CopyWith()
class MomoUser {
  final String id;
  @JsonKey(name: 'display_name')
  final String name;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'last_login')
  final DateTime lastLogin;
  @JsonKey(name: 'network_id')
  final String network;

  const MomoUser({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.lastLogin,
    required this.network,
  });
}
