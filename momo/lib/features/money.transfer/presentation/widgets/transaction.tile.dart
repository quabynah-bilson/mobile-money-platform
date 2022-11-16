import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/theme.dart';
import 'package:momo/features/money.transfer/domain/entities/transaction/transaction.dart';
import 'package:uuid/uuid.dart';

/// tile for each transaction carried out by customer
class TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionTile({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadiusSmall),
          border: Border.all(
            color: context.theme.disabledColor.withOpacity(kEmphasisLowest),
          ),
          color: context.colorScheme.surface,
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: ListTile(
          leading: Icon(
            transaction.type.toLowerCase() == TransactionType.cashout.name
                ? TablerIcons.arrow_up_right
                : transaction.type.toLowerCase() ==
                        TransactionType.transfer.name
                    ? TablerIcons.arrows_left_right
                    : TablerIcons.arrow_down_right,
            color:
                transaction.type.toLowerCase() == TransactionType.transfer.name
                    ? ThemeConfig.kGreen
                    : ThemeConfig.kRed,
          ),
          title: Text(transaction.reference.capitalize()),
          subtitle: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: transaction.timestamp.format('d M , Y')),
                TextSpan(text: '\t\t(${transaction.type.capitalize()})'),
              ],
            ),
          ),
          trailing: Icon(
            TablerIcons.dots_vertical,
            color: context.colorScheme.onSurface.withOpacity(kEmphasisLow),
          ),
        ),
      );
}

final kSampleTransactions = <Transaction>[
  Transaction(
    id: const Uuid().v4(),
    type: TransactionType.payment.name,
    sender: '+233554635701',
    recipient: '+233554022344',
    amount: 5.0,
    timestamp: DateTime.now(),
    reference: 'MTN Airtime',
  ),
  Transaction(
    id: const Uuid().v4(),
    type: TransactionType.cashout.name,
    sender: '+233554635701',
    recipient: '+23355123456',
    amount: 5.0,
    timestamp: DateTime.now(),
    reference: 'Benjamin Kwesi',
  ),
  Transaction(
    id: const Uuid().v4(),
    type: TransactionType.payment.name,
    sender: '+233554635701',
    recipient: '+233554022344',
    amount: 5.0,
    timestamp: DateTime.now(),
    reference: 'MTN Airtime',
  ),
  Transaction(
    id: const Uuid().v4(),
    type: TransactionType.payment.name,
    sender: '+233554635701',
    recipient: '+233207996951',
    amount: 5.0,
    timestamp: DateTime.now(),
    reference: 'Vodafone Push',
  ),
  Transaction(
    id: const Uuid().v4(),
    type: TransactionType.transfer.name,
    sender: '+233554635701',
    recipient: '+233554635701',
    amount: 100.0,
    timestamp: DateTime.now(),
    reference: 'Dennis Quabynah Bilson',
  ),
];
