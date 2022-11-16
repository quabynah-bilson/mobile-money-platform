import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/router/route.gr.dart';
import 'package:momo/core/user.session.dart';
import 'package:momo/core/validator.dart';
import 'package:momo/features/auth/presentation/manager/auth_cubit.dart';
import 'package:momo/features/shared/presentation/manager/bloc.state.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/animated.list.dart';
import 'package:momo/features/shared/presentation/widgets/app.text.field.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:momo/features/shared/presentation/widgets/rounded.button.dart';
import 'package:pinput/pinput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authCubit = AuthCubit(),
      _formKey = GlobalKey<FormState>(),
      _phoneNumberController = TextEditingController(),
      _pinController = TextEditingController();
  var _loading = false;

  @override
  Widget build(BuildContext context) => BlocListener(
        bloc: _authCubit,
        listener: (context, state) {
          if (!mounted) return;

          setState(() => _loading = state is LoadingState);

          if (state is ErrorState<String>) {
            _pinController.clear();
            context.showSnackBar(
                state.failure,
                context.colorScheme.errorContainer,
                context.colorScheme.onErrorContainer);
          }

          if (state is SuccessState<String>) _verifyOtpAndLogin();
        },
        child: Scaffold(
          backgroundColor: context.colorScheme.primary,
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
                    'Sign in to get started',
                    style: context.theme.textTheme.headline4
                        ?.copyWith(color: context.colorScheme.onPrimary),
                  ),
                  SizedBox(height: context.height * 0.1),
                  Form(
                    key: _formKey,
                    child: AnimatedColumn(
                      animateType: AnimateType.slideLeft,
                      children: [
                        AppTextField(
                          'Your phone number',
                          controller: _phoneNumberController,
                          action: TextInputAction.next,
                          textFieldType: AppTextFieldType.phone,
                          enabled: !_loading,
                          autofocus: true,
                          onChange: (input) => setState(() =>
                              UserSessionHandler.kPhoneNumber =
                                  input?.replaceAll(' ', '').trim()),
                          validator: Validators.validatePhone,
                        ),
                        Pinput(
                          controller: _pinController,
                          enabled: !_loading,
                          length: 4,
                          validator: Validators.validate,
                          onChanged: (input) =>
                              input.length == 4 ? _login() : null,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsRetrieverApi,
                          useNativeKeyboard: true,
                          obscureText: true,
                          obscuringCharacter: '*',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  AppRoundedButton(
                    text: 'Validate',
                    onTap: _login,
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

  /// verify otp and login
  void _verifyOtpAndLogin() async {
    var successful = await context.router.push(
        VerifyOtpRoute(phoneNumber: UserSessionHandler.kPhoneNumber ?? ''));

    if (successful is bool && successful) {
      context.router
          .pushAndPopUntil(const DashboardRoute(), predicate: (_) => false);
    }
  }

  /// login
  void _login() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      var phoneNumber = _phoneNumberController.text.trim(),
          pin = _pinController.text.trim();
      _authCubit.login(phoneNumber: phoneNumber, pin: pin);
    }
  }
}
