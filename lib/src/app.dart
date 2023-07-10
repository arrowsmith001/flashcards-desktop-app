
import 'dart:async';

import 'package:firedart/generated/google/firestore/v1/document.pbjson.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/style/minimal_theme.dart';
import 'package:flashcard_desktop_app/src/views/main_view.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'custom/views/windows/surrounded_app_window.dart';
import 'custom/widgets/gradient_background_widget.dart';
import 'navigation/route_generator.dart';

class FlashcardThemeChangeNotifier extends ValueNotifier<ThemeData> {
  FlashcardThemeChangeNotifier(super.value);
}


class MyApp extends StatelessWidget {

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

  return ChangeNotifierProvider<FlashcardThemeChangeNotifier>(
    lazy: true,
    create: (_) => FlashcardThemeChangeNotifier(MinimalTheme.theme),
    child: Consumer<FlashcardThemeChangeNotifier>(
      builder: (_, notifier, __) => _buildGradientBackgroundApp(notifier.value))
  );
  }

  Widget _buildGradientBackgroundApp(ThemeData theme) {

    return GradientBackgroundWidget(
      theme: theme, 
      child: _buildApp(theme));
  }

  MaterialApp _buildApp(ThemeData theme) {
    return MaterialApp(
            theme: theme,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: RouteGenerator.mainRoute);
  }

}

