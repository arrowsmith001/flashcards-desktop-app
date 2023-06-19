
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:window_manager/window_manager.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();


  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  var config = await AppConfig.forEnvironment('dev');


  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(MyApp(config, settingsController: settingsController));
}
