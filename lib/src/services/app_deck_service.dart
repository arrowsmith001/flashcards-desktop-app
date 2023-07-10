import '../custom/data/abstract/auth_service.dart';
import '../custom/data/abstract/repository.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../model/entities/flashcard.dart';

class AppDeckService 
{
  AppDeckService(this.authRepo, this.deckCollectionRepo, this.deckRepo, this.flashcardRepo);

  final AuthService authRepo;
  final Repository<DeckCollection> deckCollectionRepo;
  final Repository<Deck> deckRepo;
  final Repository<Flashcard> flashcardRepo;

  Future<List<DeckCollection>> getAllCollections() async {
    return await deckCollectionRepo.getAll();
  }

  Future<void> addDeckCollection(DeckCollection deckCollection) async {
    await deckCollectionRepo.createItem(deckCollection);
  }

}