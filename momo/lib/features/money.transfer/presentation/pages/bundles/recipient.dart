part of '../bundle.purchase.dart';

class _SelectRecipientPage extends StatefulWidget {
  final void Function() onSelect;
  final bool loading;

  const _SelectRecipientPage({
    Key? key,
    required this.onSelect,
    this.loading = false,
  }) : super(key: key);

  @override
  State<_SelectRecipientPage> createState() => _SelectRecipientPageState();
}

class _SelectRecipientPageState extends State<_SelectRecipientPage> {
  var _showRecipientNumberField = false;
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) => AnimationLimiter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.custom(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
              childrenDelegate: SliverChildListDelegate(
                AnimationConfiguration.toStaggeredList(
                  duration: kListAnimationDuration,
                  childAnimationBuilder: (child) => SlideAnimation(
                    verticalOffset: kListSlideOffset,
                    child: FadeInAnimation(child: child),
                  ),
                  children: [
                    DashboardActionTile(
                      label: 'Self',
                      icon: Icons.account_circle_outlined,
                      onTap: () {
                        setState(() => _showRecipientNumberField = false);
                        widget.onSelect();
                      },
                    ),
                    DashboardActionTile(
                      label: 'Others',
                      icon: Icons.supervised_user_circle_outlined,
                      active: _showRecipientNumberField,
                      onTap: () =>
                          setState(() => _showRecipientNumberField = true),
                    ),
                    // todo => show favorites sheet
                    const DashboardActionTile(
                      label: 'Favorites',
                      icon: TablerIcons.heart_plus,
                    ),
                  ],
                ),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 16,
              ),
            ),
            if (_showRecipientNumberField) ...{
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 16),
                child: AppTextField(
                  'Enter phone number',
                  controller: _numberController,
                  textFieldType: AppTextFieldType.phone,
                  validator: Validators.validatePhone,
                  enabled: !widget.loading,
                  autofocus: true,
                ),
              ),
              FloatingActionButton.extended(
                heroTag: 'validate-phone-number',
                onPressed: widget.onSelect,
                backgroundColor: context.colorScheme.onPrimary,
                foregroundColor: context.colorScheme.primary,
                icon: const Icon(TablerIcons.arrow_right),
                label: const Text('Next'),
              ),
            },
          ],
        ),
      );
}
