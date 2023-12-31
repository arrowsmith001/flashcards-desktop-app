import 'dart:math';

import 'package:flashcard_desktop_app/src/providers/app_service_providers.dart';
import 'package:flashcard_desktop_app/src/services/fake_services.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/entity_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/implemented/local.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';
import 'package:flashcard_desktop_app/src/services/app_database_services.dart';
import 'package:flashcard_desktop_app/src/services/app_data_service.dart';
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


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  final wm = AppWindowManager();
  await wm.initialize();

  final config = AppConfig();
  await config.configureForEnvironment('dev');

  final services = FlashcardAppLocalServices();
  await services.initialize(config);

  runApp(ProviderScope(
    overrides: [

    windowManagerProvider.overrideWith((ref) => wm),
    appConfigProvider.overrideWith((ref) => config),
    authServiceProvider.overrideWith((ref) => services.authService),

    userRepoProvider.overrideWith((ref) => Repository(services.userService)),
    flashcardRepoProvider
        .overrideWith((ref) => Repository(services.flashcardService)),

    deckRepoProvider.overrideWith((ref) => Repository(services.deckService)),
    deckCollectionRepoProvider
        .overrideWith((ref) => Repository(services.deckCollectionService)), 
        

/*     dbServiceProvider.overrideWith((ref) => AppDeckService(
       authRepo: ref.read(authServiceProvider),
       deckCollectionRepo:  ref.read(deckCollectionRepoProvider),
       deckRepo:  ref.read(deckRepoProvider),
       flashcardRepo:  ref.read(flashcardRepoProvider))), */

    dbServiceProvider.overrideWith((ref) => FakeAppDeckService()),

  ], child: MyApp()));
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
