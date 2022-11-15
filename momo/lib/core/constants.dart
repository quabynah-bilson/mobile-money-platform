import 'package:flutter/foundation.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:logger/logger.dart';
import 'package:new_version/new_version.dart';

/// for debugging
final logger = Logger();
bool kIsReleased = kReleaseMode;

/// app versioning
NewVersion? kAppVersionUpgrader;

/// app constants
const kAppName = 'Q-Money.';
const kAppDesc = 'A mobile money transfer platform';
const kCurrency = '₵';
final kAppDevTeam =
    'Created by Quabynah Codelabs LLC © ${DateTime.now().year} & inspired by @LalaHabibova (Behance)';
const kAppLogo = 'assets/logo.png';
// reference: https://lottiefiles.com/55607-flying-wallet-money
const kAppLoadingAnimation = 'assets/wallet_money.json';
const kAppOnboardingImage = 'assets/user_with_phone_in_hand.webp';
const kFeatureUnderDev =
    'This feature will be available in the next major release';
const kAuthRequired = 'Sign in to access your notes';

/// radius
const kRadiusSmall = 8.0;
const kRadiusMedium = 24.0;
const kRadiusLarge = 40.0;
const kRadiusLargest = 100.0;

/// opacity
const kEmphasisHigh = 0.85;
const kEmphasisMedium = 0.67;
const kEmphasisLow = 0.38;
const kEmphasisNoteBackground = 0.25;
const kEmphasisLowest = 0.1;

/// animations & transitions
const kSampleDelay = Duration(seconds: 3);
const kScrollAnimationDuration = Duration(milliseconds: 150);
const kListAnimationDuration = Duration(milliseconds: 550);
const kGridAnimationDuration = Duration(milliseconds: 850);
const kContentAnimationDuration = Duration(seconds: 1);
const kListSlideOffset = 100.0;
const kHomeFabTag = 'momo-home';
const kOptionsFabTag = 'momo-options-sheet';

/// local storage preferences (keys)
const kUserIdKey = 'momo-id-key';

String formatAmount(double value) {
  return toCurrencyString('$value',
      leadingSymbol: kCurrency/*, useSymbolPadding: true*/);
}
