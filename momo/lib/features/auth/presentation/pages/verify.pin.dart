// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/modals.dart';
import 'package:momo/core/router/route.gr.dart';
import 'package:momo/core/user.session.dart';
import 'package:momo/core/validator.dart';
import 'package:momo/features/auth/presentation/manager/auth_cubit.dart';
import 'package:momo/features/shared/presentation/manager/bloc.state.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/animated.list.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:momo/features/shared/presentation/widgets/rounded.button.dart';
import 'package:pinput/pinput.dart';

class VerifyPinPage extends StatefulWidget {
  final String phoneNumber;

  const VerifyPinPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerifyPinPage> createState() => _VerifyPinPageState();
}

class _VerifyPinPageState extends State<VerifyPinPage> {
  final _pinController = TextEditingController(),
      _formKey = GlobalKey<FormState>(),
      _authCubit = AuthCubit();
  var _loading = false;

  @override
  Widget build(BuildContext context) => BlocListener(
        bloc: _authCubit,
        listener: (context, state) {
          if (!mounted) return;

          setState(() => _loading = state is LoadingState);

          if (state is ErrorState<String>) {
            _pinController.clear();
            showMessageSheet(context, message: state.failure);
          }

          if (state is SuccessState<String>) {
            context.router.pop(true);
          }
        },
        child: Scaffold(
          backgroundColor: context.colorScheme.primary,
          body: LoadingOverlay(
            isLoading: _loading,
            child: SafeArea(
              bottom: false,
              child: AnimatedListView(
                animateType: AnimateType.slideUp,
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                children: [
                  Text(
                    kAppName,
                    style: context.theme.textTheme.headline6
                        ?.copyWith(color: context.colorScheme.onPrimary),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Enter the mobile money PIN associated with ${widget.phoneNumber}',
                    style: context.theme.textTheme.headline5
                        ?.copyWith(color: context.colorScheme.onPrimary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.height * 0.1),
                  Form(
                    key: _formKey,
                    child: Pinput(
                      controller: _pinController,
                      enabled: !_loading,
                      length: 4,
                      validator: Validators.validate,
                      onChanged: (input) =>
                          input.length == 4 ? _validatePin() : null,
                      autofocus: true,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsRetrieverApi,
                      useNativeKeyboard: true,
                      obscureText: true,
                      obscuringCharacter: '*',
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppRoundedButton(
                    text: 'Verify',
                    onTap: _validatePin,
                    enabled: !_loading,
                    buttonType: AppButtonType.swipeable,
                    backgroundColor: context.colorScheme.secondary,
                    textColor: context.colorScheme.onSecondary,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: FloatingActionButton.extended(
                          heroTag: 'logout',
                          elevation: 0,
                          onPressed: () {
                            _authCubit.logout();
                            context.router.pushAndPopUntil(
                                const OnboardingRoute(),
                                predicate: (_) => false);
                          },
                          icon: const Icon(TablerIcons.logout),
                          backgroundColor: context.colorScheme.errorContainer,
                          foregroundColor: context.colorScheme.onErrorContainer,
                          label: const Text('Sign out'),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: FloatingActionButton.extended(
                          heroTag: 'back',
                          onPressed: context.router.pop,
                          elevation: 0,
                          icon: const Icon(TablerIcons.arrow_back_up),
                          backgroundColor: context.colorScheme.onPrimary,
                          foregroundColor: context.colorScheme.primary,
                          label: const Text('Back'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  /// validate pin
  void _validatePin() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      var pin = _pinController.text.trim();
      _authCubit.login(
          phoneNumber: UserSessionHandler.kPhoneNumber ?? '', pin: pin);
    }
  }
}
