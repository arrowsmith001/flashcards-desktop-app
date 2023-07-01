
import 'dart:async';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/style/minimal_theme.dart';
import 'package:flashcard_desktop_app/src/views/main_view.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'custom/views/windows/surrounded_app_window.dart';
import 'navigation/app_navigation.dart';


class MyApp extends StatelessWidget {


  MyApp({super.key});


  @override
  Widget build(BuildContext context) {

  return MaterialApp(
          theme: MinimalTheme.theme,
          onGenerateRoute: AppNavigation.generateRoute,
          initialRoute: '/',
          builder: (context, child)
          {
            return SurroundedAppWindow(

              child: FutureBuilder(
                future: GetIt.I.allReady(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData || child == null) return Center(child: CircularProgressIndicator());
                  return child;
                }),
            );
          });
  }

}


