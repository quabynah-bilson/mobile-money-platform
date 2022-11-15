import 'package:flutter/material.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/features/shared/presentation/widgets/animated.column.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Center(
        child: AnimatedColumn(
          children: [
            Text(kAppName, style: context.theme.textTheme.headline4),
            Text(
              kAppDesc,
              style: context.theme.textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
}
