import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:window_manager/window_manager.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'package:firebase_core/firebase_core.dart';






/// The Widget that configures your application.
class MyApp extends StatelessWidget {

  MyApp(this.config, {
    super.key,
    required this.settingsController,
  })
  {
    windowManager.setAlwaysOnTop(true);
  }

  final AppConfig config;

  Future<void> setup() async {

      
    await Firebase.initializeApp();
    // TODO: Figure out Firebase API
  }
  

  final SettingsController settingsController;
  final Logger logger = Logger();

  @override
  Widget build(BuildContext context) {



    return FutureBuilder(
      builder: (context, snapshot) => 
      MaterialApp(builder: (ctx, child)
       => TextButton(
        onPressed: () => FirebaseFirestore.instance.collection("flashcards").get().then((value) => logger.d(value.docs.first.id)), 
        child: Text("Click me"))), 
      future: setup());
    

    // TODO: Get Firebase working



    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case SampleItemListView.routeName:
                  default:
                    return const SampleItemListView();
                }
              },
            );
          },
        );
      },
    );
  }
}
