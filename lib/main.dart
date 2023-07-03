
import 'dart:math';

import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/services/app_database_service.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';
import 'src/custom/data/abstract/store.dart';
import 'src/model/entities/deck.dart';
import 'src/model/entities/deck_collection.dart';
import 'src/model/entities/user.dart';

GetIt get g => GetIt.I;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencyInjection();

  runApp(MyApp());
}

Future<void> configureDependencyInjection() async
{ 
  configureAppConfig();
  configureWindowManager();

  configureDataServices();
  configureDataStores();
  configureDatabaseServices();

  configureAuth();

  await g.allReady();
}

void firebase() async {
  final auth = GetIt.I.get<AuthService>();
  final config = GetIt.I.get<AppConfigManager>();
  await auth.loginWithEmailAndPassword(config.email!, config.password!);
  
  final deckService = await GetIt.I.get<DeckService>();
  final colService = await GetIt.I.get<DeckCollectionService>();

  final decks = await deckService.getAllDecks();
  final paths = [
    'Path A/Path B-1/Path ABCD',
    'Path 1/Path B-1/Path 3',
    'Path 1/Path B-1/Path 4',
    'Path 1/Path B-2',
  ];
  final col = await colService.getCollectionById('id');
  final map = {};
  for(var d in decks)
  {
      final rand = Random();
      final int i = rand.nextInt(paths.length);
      map.addAll({d.id : paths[i]});
  }
  colService.setPathsToDecks(col!.id, map);
}

void configureAuth() {

  g.registerLazySingleton<AuthService>(()
  {
      final firebaseServices = g.get<FlashcardAppFirebaseServices>();
      return firebaseServices.authService;
  });
}

void configureDataServices() {

  g.registerLazySingleton<UserService>(() 
    => UserService(g.get<Store<User>>()));

  g.registerLazySingleton<FlashcardService>(() 
    => FlashcardService(g.get<Store<Flashcard>>()));

  g.registerLazySingleton<DeckService>(() 
    => DeckService(g.get<Store<Deck>>()));

  g.registerLazySingleton<DeckCollectionService>(() 
    => DeckCollectionService(g.get<Store<DeckCollection>>()));

}

void configureDataStores() {

  g.registerLazySingleton<Store<User>>(() 
    => Store<User>(g.get<DatabaseService<User>>()));

  g.registerLazySingleton<Store<Flashcard>>(() 
    => Store<Flashcard>(g.get<DatabaseService<Flashcard>>()));

  g.registerLazySingleton<Store<Deck>>(() 
    => Store<Deck>(g.get<DatabaseService<Deck>>()));

  g.registerLazySingleton<Store<DeckCollection>>(() 
    => Store<DeckCollection>(g.get<DatabaseService<DeckCollection>>()));
}

void configureDatabaseServices() {
    
  g.registerLazySingleton<DatabaseService<User>>(() 
    {
      final firebaseServices = g.get<FlashcardAppFirebaseServices>();
      return firebaseServices.userService;
    });
    
  g.registerLazySingleton<DatabaseService<Flashcard>>(() 
    {
      final firebaseServices = g.get<FlashcardAppFirebaseServices>();
      return firebaseServices.flashcardService;
    });

  g.registerLazySingleton<DatabaseService<Deck>>(() 
    {
      final firebaseServices = g.get<FlashcardAppFirebaseServices>();
      return firebaseServices.deckService;
    });

  g.registerLazySingleton<DatabaseService<DeckCollection>>(() 
    {
      final firebaseServices = g.get<FlashcardAppFirebaseServices>();
      return firebaseServices.deckCollectionService;
    });

    // Firebase services
    g.registerSingletonAsync<FlashcardAppFirebaseServices>(() async
    {
        final service = FlashcardAppFirebaseServices();
        await service.initialize(await g.getAsync<AppConfigManager>());
        return service;
    }, dependsOn: [AppConfigManager]);
}

void configureWindowManager() => g.registerSingletonAsync<WindowManagerWrapper>(() async 
{
  final wm = WindowManagerWrapper();
  await wm.initialize();
  return wm;
});

void configureAppConfig() {
  return g.registerSingletonAsync<AppConfigManager>(() async {
  final config = AppConfigManager();
  await config.configureForEnvironment('dev');
  return config;
});
}

