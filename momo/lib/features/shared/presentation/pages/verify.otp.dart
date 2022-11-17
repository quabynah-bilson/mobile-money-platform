// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/modals.dart';
import 'package:momo/core/validator.dart';
import 'package:momo/features/auth/presentation/manager/auth_cubit.dart';
import 'package:momo/features/shared/presentation/manager/bloc.state.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/animated.list.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:momo/features/shared/presentation/widgets/rounded.button.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpPage extends StatefulWidget {
  final String phoneNumber;

  const VerifyOtpPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final _pinController = TextEditingController(),
      _formKey = GlobalKey<FormState>(),
      _authCubit = AuthCubit(),
      _verificationCubit = AuthCubit();
  var _loading = false;

  @override
  void initState() {
    super.initState();
    doAfterDelay(
        () => _verificationCubit.sendOtp(phoneNumber: widget.phoneNumber));
  }

  @override
  Widget build(BuildContext context) => MultiBlocListener(
        listeners: [
          /// auth
          BlocListener(
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
          ),

          /// verification
          BlocListener(
            bloc: _verificationCubit,
            listener: (context, state) {
              if (!mounted) return;

              setState(() => _loading = state is LoadingState);

              if (state is ErrorState<String>) {
                _pinController.clear();
                showMessageSheet(context, message: state.failure);
              }

              if (state is SuccessState<String>) {
                showMessageSheet(context, message: state.data);
              }
            },
          ),
        ],
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
                    'Enter the verification code sent to ${widget.phoneNumber}',
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
                      length: 6,
                      validator: Validators.validate,
                      onChanged: (input) => input.length == 6
                          ? _validateVerificationCode()
                          : null,
                      autofocus: true,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsRetrieverApi,
                      useNativeKeyboard: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppRoundedButton(
                    text: 'Confirm',
                    onTap: _validateVerificationCode,
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

  /// validate pin
  void _validateVerificationCode() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      var code = _pinController.text.trim();
      _authCubit.verifyOtp(phoneNumber: widget.phoneNumber, code: code);
    }
  }
}
