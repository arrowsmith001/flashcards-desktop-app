import 'dart:async';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../main.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../services/app_deck_service.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
//part 'deck_list_notifier.g.dart';

// TODO: Implement

//@Riverpod(keepAlive: true)
class DeckListNotifier extends FamilyAsyncNotifier<List<String>, String> {
  @override
  FutureOr<List<String>> build(String arg) async {
    final notifierFuture = ref.read(deckCollectionNotifierProvider(arg).future);
    final collection = await notifierFuture;
    return collection.deckIds;
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
/* 
  List<DeckNotifier> _notifiersFromModels(List<Deck> decks) => decks
      .map<DeckNotifier>((e) => ref.read(deckNotifierProvider(e).notifier))
      .toList(); */



/*   List<Deck> getDecks() {
    return state.value?.map((e) => e.state).toList() ?? [];
  } */
}



final deckListNotifierProvider = AsyncNotifierProvider.family<DeckListNotifier, List<String>, String>(() {
  return DeckListNotifier();
});