// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:momo/features/auth/presentation/pages/user.setup.dart' as _i5;
import 'package:momo/features/auth/presentation/pages/verify.pin.dart' as _i6;
import 'package:momo/features/money.transfer/presentation/pages/add.wallet.dart'
    as _i7;
import 'package:momo/features/money.transfer/presentation/pages/wallet.details.dart'
    as _i8;
import 'package:momo/features/shared/domain/entities/wallet/wallet.dart'
    as _i11;
import 'package:momo/features/shared/presentation/pages/dashboard.dart' as _i2;
import 'package:momo/features/shared/presentation/pages/dashboard.options.dart'
    as _i3;
import 'package:momo/features/shared/presentation/pages/onboarding.dart' as _i1;
import 'package:momo/features/shared/presentation/pages/verify.otp.dart' as _i4;

class MomoAppRouter extends _i9.RootStackRouter {
  MomoAppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    OnboardingRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.OnboardingPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.DashboardPage(),
      );
    },
    DashboardOptionsRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.DashboardOptionsPage(),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i4.VerifyOtpPage(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    UserSetupRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.UserSetupPage(),
      );
    },
    VerifyPinRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyPinRouteArgs>();
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i6.VerifyPinPage(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    AddWalletRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.AddWalletPage(),
      );
    },
    WalletDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<WalletDetailsRouteArgs>();
      return _i9.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.WalletDetailsPage(
          key: args.key,
          wallet: args.wallet,
        ),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          OnboardingRoute.name,
          path: '/',
        ),
        _i9.RouteConfig(
          DashboardRoute.name,
          path: '/dashboard-page',
        ),
        _i9.RouteConfig(
          DashboardOptionsRoute.name,
          path: '/dashboard-options-page',
        ),
        _i9.RouteConfig(
          VerifyOtpRoute.name,
          path: '/verify-otp-page',
        ),
        _i9.RouteConfig(
          UserSetupRoute.name,
          path: '/user-setup-page',
        ),
        _i9.RouteConfig(
          VerifyPinRoute.name,
          path: '/verify-pin-page',
        ),
        _i9.RouteConfig(
          AddWalletRoute.name,
          path: '/add-wallet-page',
        ),
        _i9.RouteConfig(
          WalletDetailsRoute.name,
          path: '/wallet-details-page',
        ),
      ];
}

/// generated route for
/// [_i1.OnboardingPage]
class OnboardingRoute extends _i9.PageRouteInfo<void> {
  const OnboardingRoute()
      : super(
          OnboardingRoute.name,
          path: '/',
        );

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i9.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: '/dashboard-page',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i3.DashboardOptionsPage]
class DashboardOptionsRoute extends _i9.PageRouteInfo<void> {
  const DashboardOptionsRoute()
      : super(
          DashboardOptionsRoute.name,
          path: '/dashboard-options-page',
        );

  static const String name = 'DashboardOptionsRoute';
}

/// generated route for
/// [_i4.VerifyOtpPage]
class VerifyOtpRoute extends _i9.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i10.Key? key,
    required String phoneNumber,
  }) : super(
          VerifyOtpRoute.name,
          path: '/verify-otp-page',
          args: VerifyOtpRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
        );

  static const String name = 'VerifyOtpRoute';
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({
    this.key,
    required this.phoneNumber,
  });

  final _i10.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i5.UserSetupPage]
class UserSetupRoute extends _i9.PageRouteInfo<void> {
  const UserSetupRoute()
      : super(
          UserSetupRoute.name,
          path: '/user-setup-page',
        );

  static const String name = 'UserSetupRoute';
}

/// generated route for
/// [_i6.VerifyPinPage]
class VerifyPinRoute extends _i9.PageRouteInfo<VerifyPinRouteArgs> {
  VerifyPinRoute({
    _i10.Key? key,
    required String phoneNumber,
  }) : super(
          VerifyPinRoute.name,
          path: '/verify-pin-page',
          args: VerifyPinRouteArgs(
            key: key,
            phoneNumber: phoneNumber,
          ),
        );

  static const String name = 'VerifyPinRoute';
}

class VerifyPinRouteArgs {
  const VerifyPinRouteArgs({
    this.key,
    required this.phoneNumber,
  });

  final _i10.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'VerifyPinRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i7.AddWalletPage]
class AddWalletRoute extends _i9.PageRouteInfo<void> {
  const AddWalletRoute()
      : super(
          AddWalletRoute.name,
          path: '/add-wallet-page',
        );

  static const String name = 'AddWalletRoute';
}

/// generated route for
/// [_i8.WalletDetailsPage]
class WalletDetailsRoute extends _i9.PageRouteInfo<WalletDetailsRouteArgs> {
  WalletDetailsRoute({
    _i10.Key? key,
    required _i11.Wallet wallet,
  }) : super(
          WalletDetailsRoute.name,
          path: '/wallet-details-page',
          args: WalletDetailsRouteArgs(
            key: key,
            wallet: wallet,
          ),
        );

  static const String name = 'WalletDetailsRoute';
}

class WalletDetailsRouteArgs {
  const WalletDetailsRouteArgs({
    this.key,
    required this.wallet,
  });

  final _i10.Key? key;

  final _i11.Wallet wallet;

  @override
  String toString() {
    return 'WalletDetailsRouteArgs{key: $key, wallet: $wallet}';
  }
}
