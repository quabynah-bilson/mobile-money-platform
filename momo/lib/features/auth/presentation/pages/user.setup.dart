import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/router/route.gr.dart';
import 'package:momo/core/user.session.dart';
import 'package:momo/core/validator.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/app.text.field.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:momo/features/shared/presentation/widgets/rounded.button.dart';

class UserSetupPage extends StatefulWidget {
  const UserSetupPage({Key? key}) : super(key: key);

  @override
  State<UserSetupPage> createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage> {
  final _formKey = GlobalKey<FormState>(),
      _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: LoadingOverlay(
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
            child: AnimatedColumn(
              animateType: AnimateType.slideRight,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kAppName,
                  style: context.theme.textTheme.headline6
                      ?.copyWith(color: context.colorScheme.onPrimary),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tell us about yourself...',
                  style: context.theme.textTheme.headline4
                      ?.copyWith(color: context.colorScheme.onPrimary),
                ),
                SizedBox(height: context.height * 0.1),
                Form(
                  key: _formKey,
                  child: AppTextField(
                    'Your full name',
                    controller: _nameController,
                    capitalization: TextCapitalization.words,
                    action: TextInputAction.go,
                    inputType: TextInputType.name,
                    onChange: (input) => setState(
                        () => UserSessionHandler.kUsername = input?.trim()),
                    validator: Validators.validate,
                  ),
                ),
                AppRoundedButton(
                  text: 'Next',
                  onTap: _validateAndProceed,
                  buttonType: AppButtonType.swipeable,
                  backgroundColor: context.colorScheme.secondary,
                  textColor: context.colorScheme.onSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  /// validate and proceed
  void _validateAndProceed() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      var successful = await context.router.push(const AddWalletRoute());
      if (successful is bool && successful) {
        context.router
            .pushAndPopUntil(const DashboardRoute(), predicate: (_) => false);
      }
    }
  }
}
