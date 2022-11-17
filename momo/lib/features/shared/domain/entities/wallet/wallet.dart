import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'wallet.g.dart';

@JsonSerializable()
@CopyWith()
class Wallet {
  final String id;
  @JsonKey(name: 'account_holder')
  final String holder;
  @JsonKey(name: 'provider')
  final String provider;
  @JsonKey(name: 'phone_number')
  final String phone;
  @JsonKey(name: 'hashed_phone')
  final String hashedPhone;
  @JsonKey(name: 'owner')
  final String owner;
  final double balance;

  const Wallet({
    required this.id,
    required this.holder,
    required this.provider,
    required this.phone,
    required this.hashedPhone,
    required this.owner,
    required this.balance,
  });

  factory Wallet.fromJson(json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}

// final kSampleWallets = [
//   Wallet(
//     id: const Uuid().v4(),
//     holder: 'Dennis Bilson',
//     provider: 'MTN',
//     phone: '+233554635701',
//     hashedPhone: '+233**701',
//     balance: 240.43,
//   ),
//   Wallet(
//     id: const Uuid().v4(),
//     holder: 'Belinda Darglo',
//     provider: 'MTN',
//     phone: '+233248160863',
//     hashedPhone: '+233**863',
//     balance: 1273.06,
//   ),
//   Wallet(
//     id: const Uuid().v4(),
//     holder: 'Quabynah Bilson',
//     provider: 'MTN',
//     phone: '+233554022344',
//     hashedPhone: '+233**344',
//     balance: 3455.3,
//   ),
//   Wallet(
//     id: const Uuid().v4(),
//     holder: 'Hermoso Tesoro',
//     provider: 'Vodafone',
//     phone: '+233207996951',
//     hashedPhone: '+233**951',
//     balance: 12.89,
//   ),
// ];
