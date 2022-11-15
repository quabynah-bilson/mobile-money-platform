// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/user.session.dart';
import 'package:momo/core/validator.dart';
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
      _formKey = GlobalKey<FormState>();
  var _loading = false;

  @override
  Widget build(BuildContext context) => Scaffold(
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
      );

  // todo
  /// validate pin
  void _validatePin() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      if (_pinController.text.trim() == UserSessionHandler.kMomoPin) {
        setState(() => _loading = !_loading);
        await Future.delayed(kSampleDelay);
        context.router.pop(true);
      } else {
        setState(() => _loading = false);
        _pinController.clear();
        context.showSnackBar('Invalid PIN. Please try again');
      }
    }
  }
}
