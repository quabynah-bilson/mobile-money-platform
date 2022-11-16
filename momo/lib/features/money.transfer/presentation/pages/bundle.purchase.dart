import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/validator.dart';
import 'package:momo/features/shared/presentation/widgets/app.text.field.dart';
import 'package:momo/features/shared/presentation/widgets/dashboard.tile.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';

part 'bundles/airtime.amount.dart';

part 'bundles/confirm.payment.dart';

part 'bundles/recipient.dart';

part 'bundles/select.bundle.dart';

enum PageOptionType { initial, airtime, bundle, request }

class BundlePurchasePage extends StatefulWidget {
  const BundlePurchasePage({Key? key}) : super(key: key);

  @override
  State<BundlePurchasePage> createState() => _BundlePurchasePageState();
}

class _BundlePurchasePageState extends State<BundlePurchasePage> {
  final _pageController = PageController(), _formKey = GlobalKey<FormState>();
  var _loading = false,
      _selectedPageIndex = 0,
      _pageOptionType = PageOptionType.initial;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colorScheme.primary,
        body: LoadingOverlay(
          isLoading: _loading,
          child: WillPopScope(
            onWillPop: () async {
              // check if user has selected an initial option
              if (_selectedPageIndex != 0) {
                _pageController.animateToPage(--_selectedPageIndex,
                    duration: kScrollAnimationDuration,
                    curve: Curves.easeInOut);
                return Future.value(false);
              } else if (_pageOptionType != PageOptionType.initial) {
                setState(() => _pageOptionType = PageOptionType.initial);
                return Future.value(false);
              }

              return Future.value(true);
            },
            child: AnimationLimiter(
              child: Form(
                key: _formKey,
                child: CustomScrollView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  slivers: [
                    /// app bar
                    SliverAppBar(
                      title: const Text('Bundles & Airtime'),
                      leading: IconButton(
                        onPressed: context.router.pop,
                        icon: const Icon(TablerIcons.arrow_back),
                        color: context.colorScheme.onPrimary,
                      ),
                      backgroundColor: context.colorScheme.primary
                          .withOpacity(kEmphasisNone),
                    ),

                    /// options
                    if (_pageOptionType == PageOptionType.initial) ...{
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                        sliver: SliverGrid(
                          delegate: SliverChildListDelegate(
                            AnimationConfiguration.toStaggeredList(
                              duration: kListAnimationDuration,
                              childAnimationBuilder: (child) => SlideAnimation(
                                verticalOffset: kListSlideOffset,
                                child: FadeInAnimation(child: child),
                              ),
                              children: [
                                DashboardActionTile(
                                  label: 'Airtime',
                                  icon: TablerIcons.phone_call,
                                  onTap: () => setState(() =>
                                      _pageOptionType = PageOptionType.airtime),
                                ),
                                DashboardActionTile(
                                  label: 'Bundle',
                                  icon: TablerIcons.wifi,
                                  onTap: () => setState(() =>
                                      _pageOptionType = PageOptionType.bundle),
                                ),
                                DashboardActionTile(
                                  label: 'Request Airtime',
                                  icon: TablerIcons.git_pull_request,
                                  onTap: () => setState(() =>
                                      _pageOptionType = PageOptionType.request),
                                ),
                              ],
                            ),
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 16,
                          ),
                        ),
                      ),
                    } else ...{
                      SliverFillRemaining(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (page) =>
                              setState(() => _selectedPageIndex = page),
                          controller: _pageController,
                          children: [
                            _SelectRecipientPage(
                                onSelect: _validateInput, loading: _loading),
                            _pageOptionType == PageOptionType.bundle
                                ? const _SelectBundleTypePage()
                                : _EnterAirtimeAmountPage(loading: _loading),
                            const _ConfirmPaymentPage(),
                          ],
                        ),
                      )
                    }
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            _pageOptionType == PageOptionType.initial || _selectedPageIndex == 0
                ? null
                : FloatingActionButton.extended(
                    onPressed: _validateInput,
                    backgroundColor: context.colorScheme.onPrimary,
                    foregroundColor: context.colorScheme.primary,
                    icon: const Icon(TablerIcons.arrow_right),
                    label: const Text('Next'),
                  ),
      );

  /// trigger validation on form
  void _validateInput() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      // todo => remove delay
      setState(() => _loading = !_loading);
      await Future.delayed(kSampleDelay);
      setState(() => _loading = !_loading);
      _pageController.animateToPage(++_selectedPageIndex,
          duration: kScrollAnimationDuration, curve: Curves.easeInOut);
    }
  }
}
