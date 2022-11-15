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
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../../features/shared/presentation/pages/onboarding.dart' as _i1;

class MomoAppRouter extends _i2.RootStackRouter {
  MomoAppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    OnboardingRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.OnboardingPage(),
        opaque: true,
        barrierDismissible: false,
      );
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          OnboardingRoute.name,
          path: '/',
        )
      ];
}

/// generated route for
/// [_i1.OnboardingPage]
class OnboardingRoute extends _i2.PageRouteInfo<void> {
  const OnboardingRoute()
      : super(
          OnboardingRoute.name,
          path: '/',
        );

  static const String name = 'OnboardingRoute';
}
