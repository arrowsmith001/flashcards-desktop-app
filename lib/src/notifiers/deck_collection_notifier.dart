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
//part 'deck_collection_notifier.g.dart';

//@Riverpod(keepAlive: true)
class DeckCollectionNotifier
    extends FamilyAsyncNotifier<DeckCollection, String> {

  @override
  FutureOr<DeckCollection> build(String arg) async {
    return await _getDeckCollection(arg);
  }

  Future<void> addDeckToCollection(Deck deck, String path) async {

    try {
      final currentCollection = DeckCollection.copyFrom(state.value!);

      state = AsyncLoading();

      await ref.read(
          addDeckToCollectionProvider(deck, currentCollection, path).future);
      final deckCollection = await _getDeckCollection(currentCollection.id!);

      state = AsyncData(deckCollection);
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

/*   Future<void> deleteDeckCollection() async {
    final currentCollection = DeckCollection.copyFrom(state.value!);

    state = AsyncLoading();

    await ref.read(deleteDeckCollectionProvider(currentCollection).future);

    state = AsyncError(Exception('<deleted>'), StackTrace.current);
  } */

  Future<DeckCollection> _getDeckCollection(String id) async {
    return await ref.read(getDeckCollectionByIdProvider(id).future);
  }
}

final deckCollectionNotifierProvider = AsyncNotifierProvider.family<
    DeckCollectionNotifier, DeckCollection, String>(() {
  return DeckCollectionNotifier();
});
