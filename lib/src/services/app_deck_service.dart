import 'package:flashcard_desktop_app/src/classes/app_logger.dart';

import '../custom/data/abstract/auth_service.dart';
import '../custom/data/abstract/repository.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../model/entities/flashcard.dart';

class AppDeckService {
  AppDeckService(this.authRepo, this.deckCollectionRepo, this.deckRepo,
      this.flashcardRepo);

  final AuthService authRepo;
  final Repository<DeckCollection> deckCollectionRepo;
  final Repository<Deck> deckRepo;
  final Repository<Flashcard> flashcardRepo;

  Future<List<DeckCollection>> getAllCollections() async {
    return await deckCollectionRepo.getAll();
  }

  Future<DeckCollection> addDeckCollection(
      DeckCollection deckCollection) async {
    final c = await deckCollectionRepo.createItem(deckCollection);
    return c;
  }

  Future<void> deleteCollection(DeckCollection collection) async {
    await deckCollectionRepo.deleteItem(collection);
  }

  Future<DeckCollection> getCollectionById(String id) async {
    return await deckCollectionRepo.getItemById(id);
  }

  Future<Deck> getDeckById(String id) async {
    return await deckRepo.getItemById(id);
  }

  Future<List<Deck>> getDecksByIds(Iterable<String> ids) async {
    return await deckRepo.getItemsById(ids);
  }
}
