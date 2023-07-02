
import 'dart:async';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/style/minimal_theme.dart';
import 'package:flashcard_desktop_app/src/views/main_view.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'custom/views/windows/surrounded_app_window.dart';
import 'navigation/route_generator.dart';


class MyApp extends StatelessWidget {

  MyApp({super.key});

  ValueNotifier<ThemeData> themeNotifier = ValueNotifier(MinimalTheme.theme);


  @override
  Widget build(BuildContext context) {

  return ValueListenableBuilder<ThemeData>(
    valueListenable: themeNotifier,
    builder: (_, theme, __) { 
        return Provider<ValueNotifier<ThemeData>>(
          create: (_) => themeNotifier,
          child: MaterialApp(
              theme: theme,
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: '/'),
        );
     },
  );
  }

}


