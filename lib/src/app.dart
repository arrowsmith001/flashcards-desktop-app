import 'dart:async';

import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/firebase/flashcard_directory_streambuilder.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:window_manager/window_manager.dart';

import 'model/flashcard.dart';


class MyApp extends StatelessWidget {

  
  MyApp(this.config);

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MainScreen(config);
  }

}


class FlashcardDirectoriesSelectedChanged extends Notification 
{
  List<String> directoryIds = [];
}

class MainScreen extends StatefulWidget {
  
  final AppConfig config;
  MainScreen(this.config){
    windowManager.setAlwaysOnTop(false);
  }

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }

}

/// The Widget that configures your application.
class MainScreenState extends State<MainScreen> {


  AppConfig get config => widget.config;

  Future<bool> setup() async {

    FirebaseAuth.initialize(config.apiKey, VolatileStore());
    Firestore.initialize(config.projectId); // Firestore reuses the auth client

    var auth = FirebaseAuth.instance;
    await auth.signIn(config.email, config.password);

    return true;
  }

  Future<List<FlashcardDirectory>> fetchFlashcardDirectories() async {
    final docs = await Firestore.instance.collection("flashcardDirectories").limit(1).get();
    
    final directoriesListed = docs.map(FlashcardDirectory.fromFirestoreDocument).toList();
    directoriesListed.sort((d1, d2) => d1.path.toLowerCase().compareTo(d2.path.toLowerCase()));
    return directoriesListed;

    // TODO: Convert to tree folder structure
/*     final Map<String, List<FlashcardDirectory>> directoriesMap = {};
    for(FlashcardDirectory dir in directoriesListed)
    {
      List<String> pathSplit = dir.path.split(("/"));
      for(int i = pathSplit.length; i > 0; i--)
      {
        final currentPath = 
        if(!directoriesMap.keys.contains(dir.path))
        {
          directoriesMap[];
        }
      }

    } */
      
  } 



  bool window = false;
  

  final Logger logger = Logger();

  final FlashcardDirectoriesSelectedChanged flashcardDirectoriesSelectedChanged = FlashcardDirectoriesSelectedChanged();

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
          future: setup(),
          builder: (context, snapshot) {
            if(!snapshot.hasData || snapshot.hasError)
          {
            return MaterialApp(builder: (context, child) => 
            Scaffold(body:
             Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center, children: [Text("Logging in"), CircularProgressIndicator()],)),),);
          }

        return FutureBuilder(
          future: fetchFlashcardDirectories(),
          builder: (context, snapshot) {
            
            if(!snapshot.hasData || snapshot.hasError){
            return MaterialApp(builder: (context, child) => 
            Scaffold(body:
             Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center, children: [Text("Loading data"), CircularProgressIndicator()],)),),);
          }

          final List<FlashcardDirectory> dirs = snapshot.data!;
          
         
            return FlashcardDirectoryStreambuilder(dirs);
          }
        );
      }
    );
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