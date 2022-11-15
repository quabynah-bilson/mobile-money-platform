import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';
import 'package:momo/features/shared/presentation/widgets/app.text.field.dart';
import 'package:momo/features/shared/presentation/widgets/loading.overlay.dart';
import 'package:momo/features/shared/presentation/widgets/rounded.button.dart';

class UserSetupPage extends StatefulWidget {
  const UserSetupPage({Key? key}) : super(key: key);

  @override
  State<UserSetupPage> createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>(),
      _nameController = TextEditingController();
  var _loading = false;
  late final AnimationController controller;
  late final Animation colorAnimation, sizeAnimation;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    doAfterDelay(() async {});
  }

  @override
  Widget build(BuildContext context) {
    kUseDefaultOverlays(context);

    return Scaffold(
      body: LoadingOverlay(
        isLoading: _loading,
        child: Stack(
          children: [
            /// top-right background design
            Positioned(
              top: -(context.height * 0.1),
              right: -context.width * 0.12,
              child: Transform.rotate(
                angle: -math.pi / -8.0,
                child: AnimatedContainer(
                  duration: kListAnimationDuration,
                  height: context.height * 0.35,
                  width: context.height * 0.35,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer
                        .withOpacity(kEmphasisLow),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(kRadiusLargest),
                      bottomRight: Radius.circular(kRadiusMedium),
                    ),
                  ),
                ),
              ),
            ),

            /// bottom-left background design
            Positioned(
              bottom: -(context.height * 0.1),
              left: -context.width * 0.12,
              child: Transform.rotate(
                angle: -math.pi / -8.0,
                child: AnimatedContainer(
                  duration: kListAnimationDuration,
                  height: context.height * 0.4,
                  width: context.height * 0.6,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer
                        .withOpacity(kEmphasisLow),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(kRadiusLargest),
                    ),
                  ),
                ),
              ),
            ),

            /// content
            Positioned.fill(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
                  child: AnimatedColumn(
                    animateType: AnimateType.slideRight,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Let\'s introduce ourselves...',
                        style: context.theme.textTheme.headline4,
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
                          enabled: !_loading,
                          // validator: ,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: AppRoundedButton(
                          text: 'Next',
                          onTap: () => context.showSnackBar(kFeatureUnderDev),
                          enabled: !_loading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
