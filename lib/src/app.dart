import 'dart:async';

import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:window_manager/window_manager.dart';

import 'model/flashcard.dart';
import 'navigation/navigation_manager.dart';
import 'views/flashcard_view.dart';


class MyApp extends StatelessWidget {

  MyApp(){
  }

  final windowStyleNavigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {

    AppLogger.log(MediaQuery.of(context).size);

  return MaterialApp(
                  initialRoute: '/',
                  onGenerateRoute: NavigationManager.generateRoute,
                  color: Color.fromARGB(0, 0, 0, 0));
/*     return Navigator(
      initialRoute: '///',
      onGenerateRoute: (settings) {
        switch(settings.name)
        {
          case '/': 
          return PageRouteBuilder(
            pageBuilder: (context, anim, anim2)
          {
            return MaterialApp(
                builder: (context, child) {
                  return Scaffold(
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    appBar: AppBar(title: Text("hi")),
                    body: child,
                  );
                },
                initialRoute: '/',
                onGenerateRoute: NavigationManager.generateRoute,
                color: Colors.white);
          });
        case '/notif':
        return PageRouteBuilder(pageBuilder: (context, anim, anim2)
          {
            return MaterialApp(
          builder: (context, child) {
            return Scaffold(
              appBar: AppBar(title: Text("Flashcard App")),
              body: child,
            );
          },
          initialRoute: '/',
          onGenerateRoute: NavigationManager.generateRoute,
          color: Colors.white);
          });
      
        }
      }
    ); */
  }

}





/*     return AnimatedBuilder(
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
    ) */