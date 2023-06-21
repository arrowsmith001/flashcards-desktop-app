
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:window_manager/window_manager.dart';

// TODO: Make Flashcard deck folder structure
// TODO: Make database service


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();


  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  var success = await AppConfigManager.configureForEnvironment('dev');
  if(!success) AppLogger.log('Some variables werent configured');

  WindowOptions windowOptions = const WindowOptions(
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await AppWindowManager.setDefaultSizeAndPosition();               
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(MyApp());
}
