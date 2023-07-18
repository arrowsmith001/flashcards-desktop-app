import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard_result.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';

import '../custom/data/abstract/auth_service.dart';
import '../custom/data/abstract/repository.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../model/entities/flashcard.dart';

class AppDataService {

  AppDataService(
      {this.authRepo,
      this.deckCollectionRepo,
      this.deckRepo,
      this.flashcardRepo,
      this.flashcardResultRepo});

  final AuthService? authRepo;
  final Repository<DeckCollection>? deckCollectionRepo;
  final Repository<Deck>? deckRepo;
  final Repository<Flashcard>? flashcardRepo;
  final Repository<FlashcardResult>? flashcardResultRepo;

  AuthService get _authRepo => authRepo!;
  Repository<DeckCollection> get _deckCollectionRepo => deckCollectionRepo!;
  Repository<Deck> get _deckRepo => deckRepo!;
  Repository<Flashcard> get _flashcardRepo => flashcardRepo!;
  Repository<FlashcardResult> get _flashcardResultRepo => flashcardResultRepo!;

  Future<List<DeckCollection>> getAllDeckCollections() async {
    return await _deckCollectionRepo.getAll();
  }

  Future<DeckCollection> addDeckCollection(
      DeckCollection deckCollection) async {
    return await _deckCollectionRepo.createItem(deckCollection);
  }

  Future<void> deleteCollection(String deckCollectionId) async {
    await _deckCollectionRepo.deleteItem(deckCollectionId);
  }

  Future<DeckCollection> getDeckCollectionById(String id) async {
    return await _deckCollectionRepo.getItemById(id);
  }

  Future<Deck> getDeckById(String id) async {
    return await _deckRepo.getItemById(id);
  }

  Future<List<Deck>> getDecksByIds(Iterable<String> ids) async {
    return await _deckRepo.getItemsByIds(ids);
  }

  Future<Deck> addDeck(Deck deck) async {
    final d = await _deckRepo.createItem(deck);
    return d;
  }

  Future<void> addDeckToCollection(
      Deck deck, DeckCollection collection, String path) async {
    assert(deck.id != null);
    await _deckCollectionRepo.setField(
        collection.id!,
        DeckCollection.PATHS_TO_DECK_IDS,
        collection.deckIdsToPaths..addAll({deck.id!: path}));
  }

  Future<Flashcard> getFlashcardById(String flashcardId) async {
    return await _flashcardRepo.getItemById(flashcardId);
  }

  Future<FlashcardResult> getFlashcardResultById(String flashcardResultId) async {
    return await _flashcardResultRepo.getItemById(flashcardResultId);
  }

  Future<FlashcardResult> addFlashcardResult(FlashcardResult flashcardResult) async {
    return await _flashcardResultRepo.createItem(flashcardResult);
  }
}
