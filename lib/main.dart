
import 'dart:math';

import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/entity_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/implemented/local.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/services/app_database_services.dart';
import 'package:flashcard_desktop_app/src/services/app_deck_service.dart';
import 'package:flashcard_desktop_app/src/services/implemented/local_services.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'src/app.dart';
import 'src/custom/data/abstract/repository.dart';
import 'src/model/entities/deck.dart';
import 'src/model/entities/deck_collection.dart';
import 'src/model/entities/user.dart';


final windowManagerProvider = Provider<AppWindowManager>((ref) => throw UnimplementedError());
final appConfigProvider = Provider<AppConfig>((ref) => throw UnimplementedError());

final authServiceProvider = Provider<AuthService>((ref) => throw UnimplementedError());
final userRepoProvider = Provider<Repository<User>>((ref) => throw UnimplementedError());
final flashcardRepoProvider = Provider<Repository<Flashcard>>((ref) => throw UnimplementedError());
final deckRepoProvider = Provider<Repository<Deck>>((ref) => throw UnimplementedError());
final deckCollectionRepoProvider = Provider<Repository<DeckCollection>>((ref) => throw UnimplementedError());

final deckServiceProvider = Provider<AppDeckService>((ref) => throw UnimplementedError());


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final wm = AppWindowManager();
  await wm.initialize();

  final config = AppConfig();
  await config.configureForEnvironment('dev'); 

  final services = FlashcardAppLocalServices();
  await services.initialize(config);

  final initial = await services.deckCollectionService.fetchAll();
  AppLogger.log(initial.length);

  runApp(
    ProviderScope(
    overrides: [
      windowManagerProvider.overrideWith((ref) => wm),
      appConfigProvider.overrideWith((ref) => config),
      authServiceProvider.overrideWith((ref) => services.authService),
      userRepoProvider.overrideWith((ref) => Repository(services.userService)),
      flashcardRepoProvider.overrideWith((ref) => Repository(services.flashcardService)),
      deckRepoProvider.overrideWith((ref) => Repository(services.deckService)),
      deckCollectionRepoProvider.overrideWith((ref) => Repository(services.deckCollectionService, initialItems: initial)),
      deckServiceProvider.overrideWith((ref) => 
        AppDeckService(
          ref.read(authServiceProvider), 
          ref.read(deckCollectionRepoProvider), 
          ref.read(deckRepoProvider), 
          ref.read(flashcardRepoProvider))),
    ],
      child: MyApp()));
 
  

  
}



void firebase(config, auth, AppDatabaseServices services) async {

/*   await auth.loginWithEmailAndPassword(config.email!, config.password!);
  

  final decks = await services.deckService.getAllDecks();
  final paths = [
    'Path A/Path B-1/Path ABCD',
    'Path 1/Path B-1/Path 3',
    'Path 1/Path B-1/Path 4',
    'Path 1/Path B-2',
  ];
  final col = await services.deckCollectionService.getCollectionById('id');
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
      final appServices = g.get<FlashcardAppDatabaseServices>();
      return appServices.authService;
  }); */
}



