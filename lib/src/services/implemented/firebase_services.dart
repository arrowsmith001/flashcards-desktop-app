


import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/entity_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/repository.dart';
import 'package:flashcard_desktop_app/src/custom/data/implemented/firebase.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:flashcard_desktop_app/src/model/entities/user.dart';
import 'package:flashcard_desktop_app/src/services/app_database_services.dart';


class FlashcardAppFirebaseServices implements AppDatabaseServices
{ 
  @override
  Future<void> initialize(AppConfig config) async
  {
    FirebaseAuth.initialize(config.apiKey!, VolatileStore());
    Firestore.initialize(config.projectId!);
  }

  @override DatabaseService<User> userService = FirebaseDatabaseService('users', User.deserialize);
  @override DatabaseService<Flashcard> flashcardService = FirebaseDatabaseService('flashcards', Flashcard.deserialize);
  @override DatabaseService<Deck> deckService = FirebaseDatabaseService('decks', Deck.deserialize);
  @override DatabaseService<DeckCollection> deckCollectionService = FirebaseDatabaseService('deckCollections', DeckCollection.deserialize);
  @override AuthService authService = FirebaseAuthService();
  
}