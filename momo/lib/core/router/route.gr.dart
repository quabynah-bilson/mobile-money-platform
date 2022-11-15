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
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../features/auth/presentation/pages/user.setup.dart' as _i2;
import '../../features/shared/presentation/pages/onboarding.dart' as _i1;

class MomoAppRouter extends _i3.RootStackRouter {
  MomoAppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    OnboardingRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.OnboardingPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
    UserSetupRoute.name: (routeData) {
      return _i3.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i2.UserSetupPage(),
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          OnboardingRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          UserSetupRoute.name,
          path: '/user-setup-page',
        ),
      ];
}

/// generated route for
/// [_i1.OnboardingPage]
class OnboardingRoute extends _i3.PageRouteInfo<void> {
  const OnboardingRoute()
      : super(
          OnboardingRoute.name,
          path: '/',
        );

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [_i2.UserSetupPage]
class UserSetupRoute extends _i3.PageRouteInfo<void> {
  const UserSetupRoute()
      : super(
          UserSetupRoute.name,
          path: '/user-setup-page',
        );

  static const String name = 'UserSetupRoute';
}
