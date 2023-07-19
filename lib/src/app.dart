import 'dart:async';

import 'package:firedart/generated/google/firestore/v1/document.pbjson.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/style/minimal_theme.dart';
import 'package:flashcard_desktop_app/src/notifiers/theme_notifier.dart';
import 'package:flashcard_desktop_app/src/views/main_view.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'custom/views/windows/surrounded_app_window.dart';
import 'custom/widgets/gradient_background_widget.dart';
import 'navigation/top_level_routes.dart';

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final theme = ref.watch(themeNotifierProvider);

    return _buildApp(theme);
  }

  MaterialApp _buildApp(ThemeData theme) {
    return MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        theme: theme,
        onGenerateRoute: TopLevelRoutes.generateRoute,
        initialRoute: TopLevelRoutes.mainRoute);
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
