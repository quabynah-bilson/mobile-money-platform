import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/router/route.gr.dart';
import 'package:momo/core/theme.dart';
import 'package:momo/features/shared/presentation/widgets/dismiss.keyboard.dart';

class MomoApp extends StatefulWidget {
  const MomoApp({Key? key}) : super(key: key);

  @override
  State<MomoApp> createState() => _MomoAppState();
}

class _MomoAppState extends State<MomoApp> {
  final _router = MomoAppRouter();

  @override
  Widget build(BuildContext context) => DismissKeyboard(
        child: MaterialApp.router(
          scrollBehavior: const CupertinoScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: kAppName,
          theme: ThemeConfig.kLightThemeData(context),
          darkTheme: ThemeConfig.kDarkThemeData(context),
          // todo => add support for dark theme
          themeMode: ThemeMode.light,
          routerDelegate: _router.delegate(),
          routeInformationParser: _router.defaultRouteParser(),
        ),
      );
}
