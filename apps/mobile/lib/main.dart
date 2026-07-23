import 'package:flutter/material.dart';
import 'package:rajawali_mobile/app.dart';
import 'package:rajawali_mobile/bootstrap/app_bootstrap.dart';
import 'package:rajawali_mobile/core/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final config = AppConfig.fromEnvironment();
    final services = await AppBootstrap(config).create();
    runApp(RajawaliMobileApp(config: config, services: services));
  } on Object {
    runApp(const BootstrapFailureApp());
  }
}
