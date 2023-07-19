import 'dart:math';

import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/entity.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/repository.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard_result.dart';
import 'package:flashcard_desktop_app/src/services/app_database_services.dart';
import 'package:flashcard_desktop_app/src/services/app_data_service.dart';

class FakeAppDeckService extends AppDataService {
  int numberOfDecks = 7;
  int numberOfFlashcards = 1000;

  int _getNextIdGivenList(List<Entity> list) {
    if (list.isEmpty) return 0;
    final orderedIds = list.map((e) => int.parse(e.id!)).toList()..sort();
    return orderedIds.last + 1;
  }

  int get nextDeckId => _getNextIdGivenList(decks);
  int get nextFlashcardId => _getNextIdGivenList(flashcards);
  int get nextFlashcardResultId => _getNextIdGivenList(flashcardResults);

  List<FlashcardResult> flashcardResults = [];

  FakeAppDeckService() {
    theCollection = DeckCollection(
        '0',
        null,
        'DC_0',
        {
          '0': 'a/b/c/d',
          '1': 'a/b/c/e',
          '2': 'a/b/c',
          '3': 'a/b/c',
          '4': 'a/b/c',
          '5': 'a/b/g',
          '6': 'a/b/c/h/i/j/k',
        },
        true);

    decks = List.generate(numberOfDecks, (i) {
      return Deck('$i', 'Deck_$i', [], DateTime.now());
    });

    flashcards = List.generate(numberOfFlashcards, (i) {
      Random r = Random();
      final randomDeckId = r.nextInt(numberOfDecks);
      final flashcard =
          Flashcard('$i', 'Deck_${randomDeckId}', 'prompt $i', 'response $i');
      final deckToAddFlashcardTo = decks
          .singleWhere((deck) => deck.id == '$randomDeckId')
          .flashcards
        ..add(flashcard.id!);
      return flashcard;
    });
  }

  late DeckCollection theCollection;
  late List<Deck> decks;
  late List<Flashcard> flashcards;

  @override
  Future<void> addDeckAndAddToCollection(
      Deck deck, DeckCollection collection, String path) async {
    Deck newDeck = deck.cloneWithId('$nextDeckId');
    decks.add(newDeck);
    collection.deckIdsToPaths.addAll({newDeck.id!: path});
  }

  @override
  Future<void> deleteCollection(String deckCollectionId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<DeckCollection>> getAllDeckCollections() async {
    return [theCollection];
  }

  @override
  Future<Deck> getDeckById(String id) async {
    return decks.singleWhere((element) => id == element.id!);
  }

  @override
  Future<DeckCollection> getDeckCollectionById(String id) async {
    return theCollection;
  }

  @override
  Future<List<Deck>> getDecksByIds(Iterable<String> ids) async {
    return decks.where((element) => ids.contains(element.id!)).toList();
  }

  @override
  Future<Deck> addDeck(Deck deck) {
    
    throw UnimplementedError();
  }

  @override
  Future<DeckCollection> addDeckCollection(DeckCollection deckCollection) {
    
    throw UnimplementedError();
  }

  @override
  Future<void> addDeckToCollection(
      Deck deck, DeckCollection collection, String path) {
    
    throw UnimplementedError();
  }

  @override
  Future<FlashcardResult> addFlashcardResult(
      FlashcardResult flashcardResult) async {
    final newResult = flashcardResult.cloneWithId('$nextFlashcardResultId');
    flashcardResults.add(newResult);
    return newResult;
  }

  @override
  Future<Flashcard> getFlashcardById(String flashcardId) async {
    return flashcards.singleWhere((element) => flashcardId == element.id!);
  }

  @override
  Future<FlashcardResult> getFlashcardResultById(
      String flashcardResultId) async {
    return flashcardResults
        .singleWhere((element) => flashcardResultId == element.id!);
  }
}
