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
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:momo/features/auth/presentation/pages/login.dart' as _i5;
import 'package:momo/features/auth/presentation/pages/verify.pin.dart' as _i6;
import 'package:momo/features/money.transfer/presentation/pages/add.wallet.dart'
    as _i7;
import 'package:momo/features/money.transfer/presentation/pages/bundle.purchase.dart'
    as _i9;
import 'package:momo/features/money.transfer/presentation/pages/wallet.details.dart'
    as _i8;
import 'package:momo/features/shared/domain/entities/wallet/wallet.dart'
    as _i12;
import 'package:momo/features/shared/presentation/pages/dashboard.dart' as _i2;
import 'package:momo/features/shared/presentation/pages/dashboard.options.dart'
    as _i3;
import 'package:momo/features/shared/presentation/pages/onboarding.dart' as _i1;
import 'package:momo/features/shared/presentation/pages/verify.otp.dart' as _i4;

class MomoAppRouter extends _i10.RootStackRouter {
  MomoAppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    OnboardingRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.OnboardingPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i2.DashboardPage(),
      );
    },
    DashboardOptionsRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.DashboardOptionsPage(),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i4.VerifyOtpPage(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginPage(),
      );
    },
    VerifyPinRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyPinRouteArgs>();
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i6.VerifyPinPage(
          key: args.key,
          phoneNumber: args.phoneNumber,
        ),
      );
    },
    AddWalletRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i7.AddWalletPage(),
      );
    },
    WalletDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<WalletDetailsRouteArgs>();
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i8.WalletDetailsPage(
          key: args.key,
          wallet: args.wallet,
        ),
      );
    },
    BundlePurchaseRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i9.BundlePurchasePage(),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          OnboardingRoute.name,
          path: '/',
        ),
        _i10.RouteConfig(
          DashboardRoute.name,
          path: '/dashboard-page',
        ),
        _i10.RouteConfig(
          DashboardOptionsRoute.name,
          path: '/dashboard-options-page',
        ),
        _i10.RouteConfig(
          VerifyOtpRoute.name,
          path: '/verify-otp-page',
        ),
        _i10.RouteConfig(
          LoginRoute.name,
          path: '/login-page',
        ),
        _i10.RouteConfig(
          VerifyPinRoute.name,
          path: '/verify-pin-page',
        ),
        _i10.RouteConfig(
          AddWalletRoute.name,
          path: '/add-wallet-page',
        ),
        _i10.RouteConfig(
          WalletDetailsRoute.name,
          path: '/wallet-details-page',
        ),
        _i10.RouteConfig(
          BundlePurchaseRoute.name,
          path: '/bundle-purchase-page',
        ),
      ];
}

/// generated route for
/// [_i1.OnboardingPage]
class OnboardingRoute extends _i10.PageRouteInfo<void> {
  const OnboardingRoute()
      : super(
          OnboardingRoute.name,
          path: '/',
        );

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i10.PageRouteInfo<void> {
  const DashboardRoute()
      : super(
          DashboardRoute.name,
          path: '/dashboard-page',
        );

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i3.DashboardOptionsPage]
class DashboardOptionsRoute extends _i10.PageRouteInfo<void> {
  const DashboardOptionsRoute()
      : super(
          DashboardOptionsRoute.name,
          path: '/dashboard-options-page',
        );

  static const String name = 'DashboardOptionsRoute';
}

/// generated route for
/// [_i4.VerifyOtpPage]
class VerifyOtpRoute extends _i10.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i11.Key? key,
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

  final _i11.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i6.VerifyPinPage]
class VerifyPinRoute extends _i10.PageRouteInfo<VerifyPinRouteArgs> {
  VerifyPinRoute({
    _i11.Key? key,
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

  final _i11.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'VerifyPinRouteArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i7.AddWalletPage]
class AddWalletRoute extends _i10.PageRouteInfo<void> {
  const AddWalletRoute()
      : super(
          AddWalletRoute.name,
          path: '/add-wallet-page',
        );

  static const String name = 'AddWalletRoute';
}

/// generated route for
/// [_i8.WalletDetailsPage]
class WalletDetailsRoute extends _i10.PageRouteInfo<WalletDetailsRouteArgs> {
  WalletDetailsRoute({
    _i11.Key? key,
    required _i12.Wallet wallet,
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

  final _i11.Key? key;

  final _i12.Wallet wallet;

  @override
  String toString() {
    return 'WalletDetailsRouteArgs{key: $key, wallet: $wallet}';
  }
}

/// generated route for
/// [_i9.BundlePurchasePage]
class BundlePurchaseRoute extends _i10.PageRouteInfo<void> {
  const BundlePurchaseRoute()
      : super(
          BundlePurchaseRoute.name,
          path: '/bundle-purchase-page',
        );

  static const String name = 'BundlePurchaseRoute';
}
