


import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:get_it/get_it.dart';

import '../classes/app_config.dart';
import '../custom/data/abstract/entity_service.dart';
import '../custom/data/abstract/store.dart';
import '../custom/data/implemented/firebase.dart';
import '../model/entities/deck.dart';
import '../model/entities/user.dart';



class FlashcardAppFirebaseServices
{
  Future<void> initialize(AppConfigManager config) async
  {
    FirebaseAuth.initialize(config.apiKey!, VolatileStore());
    Firestore.initialize(config.projectId!);
  }

  DatabaseService<User> userService = FirebaseDatabaseService('users', User.deserialize);
  DatabaseService<Flashcard> flashcardService = FirebaseDatabaseService('flashcards', Flashcard.deserialize);
  DatabaseService<Deck> deckService = FirebaseDatabaseService('decks', Deck.deserialize);
  DatabaseService<DeckCollection> deckCollectionService = FirebaseDatabaseService('deckCollections', DeckCollection.deserialize);
  
  AuthService get authService => FirebaseAuthService();
  
}

class DeckService extends EntityService<Deck>
{
  DeckService(super.entityStore);
  
    Future<List<Deck>> getAllDecks() {
    return entityStore.getAll();
  }
  
  Future<bool> addFlashcardDirectory(Deck item) => entityStore.addItem(item);

}

class DeckCollectionService extends EntityService<DeckCollection>
{
  DeckCollectionService(super.entityStore);
  
    Future<DeckCollection> getCollectionById(String id) {
    return entityStore.getItemById(id);
  }

  void setPathsToDecks(String? id, Map map) {
    entityStore.setField(id!, 'pathsToDeckIds', map);
  }
  
}

class FlashcardService extends EntityService<Flashcard>
{
  FlashcardService(super.entityStore);

  Future<List<Flashcard>> getAllFlashcardsByDirectoryId(String parentDirectoryId) async {
    // TODO:  somehow refer to cached items and be as efficient in querying as possible
    return entityStore.getItemsByField('parentId', parentDirectoryId);
  }
  
  Future<bool> addFlashcard(Flashcard item) => entityStore.addItem(item);
  
}

