import 'package:flutter/material.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/theme.dart';

enum WalletType { normal, compact }

/// momo wallet card
class WalletCard extends StatelessWidget {
  final Color? background;
  final Color? foreground;
  final String accountNumber;
  final String accountHolder;
  final String accountProvider;
  final double? balance;
  final double marginEnd;
  final void Function()? onTap;
  final WalletType type;

  const WalletCard({
    Key? key,
    required this.accountNumber,
    required this.accountHolder,
    required this.accountProvider,
    this.balance,
    this.marginEnd = 0.00,
    this.type = WalletType.normal,
    this.background,
    this.foreground,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: context.height * 0.28,
          width: context.width * (type == WalletType.normal ? 0.85 : 0.62),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          margin: EdgeInsets.only(right: marginEnd),
          decoration: BoxDecoration(
            color: background ?? context.colorScheme.secondary,
            borderRadius: BorderRadius.circular(kRadiusMedium),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color:
                    context.colorScheme.onSurface.withOpacity(kEmphasisLowest),
                blurStyle: BlurStyle.normal,
                offset: const Offset(-5, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    accountProvider.toUpperCase(),
                    style:  (type == WalletType.normal
                        ? context.theme.textTheme.subtitle1
                        : context.theme.textTheme.subtitle2)?.copyWith(
                        color: (foreground ?? ThemeConfig.kWhite)
                            .withOpacity(kEmphasisMedium)),
                  ),
                  Text(
                    accountHolder.toUpperCase(),
                    style: (type == WalletType.normal
                            ? context.theme.textTheme.headline5
                            : context.theme.textTheme.subtitle1)
                        ?.copyWith(color: foreground ?? ThemeConfig.kWhite),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    balance == null ? '***' : formatAmount(balance!),
                    style: (type == WalletType.normal
                            ? context.theme.textTheme.headline3
                            : context.theme.textTheme.headline4
                                ?.copyWith(fontWeight: FontWeight.bold))
                        ?.copyWith(color: foreground ?? ThemeConfig.kWhite),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      accountNumber
                          .replaceAll('-', ' ')
                          .replaceAll('+', '')
                          .trim(),
                      style: context.theme.textTheme.headline6
                          ?.copyWith(color: foreground ?? ThemeConfig.kWhite),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
