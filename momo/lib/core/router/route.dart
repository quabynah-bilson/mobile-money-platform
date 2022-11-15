import 'package:auto_route/auto_route.dart';
import 'package:momo/features/auth/presentation/pages/user.setup.dart';
import 'package:momo/features/shared/presentation/pages/onboarding.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(page: OnboardingPage, initial: true),
    AutoRoute(page: UserSetupPage),
  ],
)
class $MomoAppRouter {}
