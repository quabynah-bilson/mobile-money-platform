import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/router/route.gr.dart';
import 'package:momo/core/validator.dart';
import 'package:momo/features/auth/presentation/manager/auth_cubit.dart';
import 'package:momo/features/shared/domain/entities/wallet/wallet.dart';
import 'package:momo/features/shared/presentation/manager/bloc.state.dart';
import 'package:momo/features/shared/presentation/manager/wallet_cubit.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/animated.list.dart';
import 'package:momo/features/shared/presentation/widgets/app.text.field.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:momo/features/shared/presentation/widgets/rounded.button.dart';

class AddWalletPage extends StatefulWidget {
  const AddWalletPage({Key? key}) : super(key: key);

  @override
  State<AddWalletPage> createState() => _AddWalletPageState();
}

class _AddWalletPageState extends State<AddWalletPage> {
  final _formKey = GlobalKey<FormState>(),
      _phoneNumberController = TextEditingController(),
      _networks = ['MTN'],
      _authCubit = AuthCubit(),
      _walletCubit = WalletCubit();
  late var _loading = false, _selectedNetwork = _networks.first;

  @override
  Widget build(BuildContext context) => BlocListener(
        bloc: _walletCubit,
        listener: (context, state) {
          if (!mounted) return;

          setState(() => _loading = state is LoadingState);

          if (state is ErrorState<String>) {
            context.showSnackBar(
                state.failure,
                context.colorScheme.errorContainer,
                context.colorScheme.onErrorContainer);
          }

          if (state is SuccessState<Wallet>) context.router.pop(true);
        },
        child: Scaffold(
          backgroundColor: context.colorScheme.primary,
          extendBody: true,
          body: LoadingOverlay(
            isLoading: _loading,
            child: SafeArea(
              bottom: false,
              child: AnimatedListView(
                animateType: AnimateType.slideRight,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                children: [
                  Text(
                    kAppName,
                    style: context.theme.textTheme.headline6
                        ?.copyWith(color: context.colorScheme.onPrimary),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Setup your wallet account...',
                    style: context.theme.textTheme.headline4
                        ?.copyWith(color: context.colorScheme.onPrimary),
                  ),
                  SizedBox(height: context.height * 0.1),
                  Form(
                    key: _formKey,
                    child: AnimatedColumn(
                      animateType: AnimateType.slideLeft,
                      children: [
                        AppDropdownField(
                          label: 'Network',
                          values: _networks,
                          onSelected: (network) =>
                              setState(() => _selectedNetwork = network),
                          current: _selectedNetwork,
                          enabled: !_loading,
                        ),
                        AppTextField(
                          'Your phone number',
                          controller: _phoneNumberController,
                          action: TextInputAction.next,
                          textFieldType: AppTextFieldType.phone,
                          enabled: !_loading,
                          autofocus: true,
                          validator: Validators.validatePhone,
                        ),
                      ],
                    ),
                  ),
                  AppRoundedButton(
                    text: 'Validate',
                    onTap: _validateAndGetAccount,
                    enabled: !_loading,
                    buttonType: AppButtonType.swipeable,
                    backgroundColor: context.colorScheme.secondary,
                    textColor: context.colorScheme.onSecondary,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: FloatingActionButton.extended(
                      onPressed: context.router.pop,
                      icon: const Icon(TablerIcons.arrow_back_up),
                      backgroundColor: context.colorScheme.onPrimary,
                      foregroundColor: context.colorScheme.primary,
                      label: const Text('Back'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  /// validate and get account for user
  void _validateAndGetAccount() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      var phoneNumber = _phoneNumberController.text.trim();

      /// verify wallet credentials
      var successful = await context.router
          .push(VerifyPinRoute(phoneNumber: formatPhoneNumber(phoneNumber)));
      if (successful is bool && successful) {
        /// validate with SMS prompt
        successful = await context.router
            .push(VerifyOtpRoute(phoneNumber: formatPhoneNumber(phoneNumber)));
        if (successful is bool && successful) {
          // todo => get user name
          _walletCubit.createWallet(
            phoneNumber: formatPhoneNumber(phoneNumber),
            name: '',
          );
        }
      }
    }
  }
}
