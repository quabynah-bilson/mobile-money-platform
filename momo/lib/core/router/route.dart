import 'package:auto_route/auto_route.dart';
import 'package:momo/features/shared/presentation/pages/onboarding.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: OnboardingPage, initial: true),
  ],
)
class $MomoAppRouter {}
