import 'dart:io';

import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/implemented/local.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:flashcard_desktop_app/src/model/entities/user.dart';
import 'package:flashcard_desktop_app/src/services/app_database_services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../custom/data/abstract/entity.dart';

class FlashcardAppLocalServices implements AppDatabaseServices {
  @override
  Future<void> initialize(AppConfig config) async {
    // TODO: disposable pattern

    if (Platform.isWindows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    var dbPath = await getDatabasesPath();
    String path = '${dbPath}/test11/demo.db';

    await deleteDatabase(path);

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      for (var t in ['Decks', 'DeckCollections', 'Flashcards', 'Users']) {
        await db.execute('CREATE TABLE $t (id INTEGER PRIMARY KEY, json TEXT)');
      }
    });
  }

  late Database database;

  @override
  late AuthService authService = LocalMockAuthService(database, userService);

  @override
  late DatabaseService<DeckCollection> deckCollectionService =
      LocalJSONDatabaseService<DeckCollection>(
          database, 'DeckCollections', DeckCollection.deserialize);

  @override
  late DatabaseService<Deck> deckService =
      LocalJSONDatabaseService<Deck>(database, 'Decks', Deck.deserialize);

  @override
  late DatabaseService<Flashcard> flashcardService =
      LocalJSONDatabaseService<Flashcard>(
          database, 'Flashcards', Flashcard.deserialize);

  @override
  late DatabaseService<User> userService =
      LocalJSONDatabaseService<User>(database, 'Users', User.deserialize);
}
