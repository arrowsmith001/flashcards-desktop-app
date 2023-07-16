import 'dart:async';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../main.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../services/app_deck_service.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
//part 'deck_notifier.g.dart';

// TODO: Implement

//@Riverpod(keepAlive: true)
class DeckNotifier extends FamilyAsyncNotifier<Deck, String> {

  @override
  FutureOr<Deck> build(String arg) async {
    return await _getDeck(arg);
  }
/* 
  AsyncValue<List<Deck>> getDecks() {
    return AsyncData(state.value.map((e) => e.state).toList());
  } */

  Future<void> addDeck(String deckId, String path) async {
    state = AsyncLoading();

    //state = AsyncData();
/* 
  List<DeckNotifier> _notifiersFromModel(List<Deck> decks) =>
      decks.map((d) => DeckNotifier(d)).toList(); */
  }
    
    
  Future<Deck> _getDeck(String id) async {
    return await ref.read(getDeckByIdProvider(id).future);
  }
/* 
  List<DeckNotifier> _notifiersFromModels(List<Deck> decks) => decks
      .map<DeckNotifier>((e) => ref.read(deckNotifierProvider(e).notifier))
      .toList(); */



/*   List<Deck> getDecks() {
    return state.value?.map((e) => e.state).toList() ?? [];
  } */
}



final deckNotifierProvider = AsyncNotifierProvider.family<DeckNotifier, Deck, String>(() {
  return DeckNotifier();
});