import 'package:auto_route/auto_route.dart';
import 'package:momo/features/auth/presentation/pages/user.setup.dart';
import 'package:momo/features/auth/presentation/pages/verify.pin.dart';
import 'package:momo/features/money.transfer/presentation/pages/add.wallet.dart';
import 'package:momo/features/money.transfer/presentation/pages/bundle.purchase.dart';
import 'package:momo/features/money.transfer/presentation/pages/wallet.details.dart';
import 'package:momo/features/shared/presentation/pages/dashboard.dart';
import 'package:momo/features/shared/presentation/pages/dashboard.options.dart';
import 'package:momo/features/shared/presentation/pages/onboarding.dart';
import 'package:momo/features/shared/presentation/pages/verify.otp.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    /// shared
    AutoRoute(page: OnboardingPage, initial: true),
    AutoRoute(page: DashboardPage),
    AutoRoute(page: DashboardOptionsPage),
    AutoRoute(page: VerifyOtpPage),

    /// auth
    AutoRoute(page: UserSetupPage),
    AutoRoute(page: VerifyPinPage),

    /// money transfer
    AutoRoute(page: AddWalletPage),
    AutoRoute(page: WalletDetailsPage),
    AutoRoute(page: BundlePurchasePage),

  ],
)
class $MomoAppRouter {}
