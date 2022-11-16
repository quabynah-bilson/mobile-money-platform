import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:momo/core/app.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/injector.dart';
import 'package:new_version/new_version.dart';
import 'package:intl/date_symbol_data_local.dart';

/// entry point
///
/// reference: https://www.behance.net/gallery/154262203/ATB-mobile-banking
/// libraries: flutter pub add google_fonts bloc flutter_bloc lottie flutter_staggered_animations shared_preferences date_time_format copy_with_extension json_annotation dartz dio uuid pinput cached_network_image url_launcher number_display tab_container package_info_plus new_version flutter_config flutter_staggered_grid_view get_it logger flutter_tabler_icons flutter_multi_formatter animated_bottom_navigation_bar timeago_flutter
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// setup device orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// load .env
  await FlutterConfig.loadEnvVariables();

  /// setup dependencies
  await setupInjector();

  /// initialize date formatting
  await initializeDateFormatting("en", "");

  /// setup app versioning
  kAppVersionUpgrader =
      NewVersion(androidId: 'io.qcodelabs.momo', iOSId: 'io.qcodelabs.momo');

  runApp(const MomoApp());
}
