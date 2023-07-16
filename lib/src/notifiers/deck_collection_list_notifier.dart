import 'dart:async';
import 'dart:convert';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../main.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../services/app_deck_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
//part 'deck_collection_list_notifier.g.dart';

// TODO: Fix family notifier...
// TODO: Add user parameter

//@Riverpod(keepAlive: true)
class DeckCollectionListNotifier extends AsyncNotifier<List<String>> {
  String? selectedDeckCollectionId;

  @override
  FutureOr<List<String>> build() async {
    return await _getDeckCollections();
  }

  Future<void> addDeckCollection(DeckCollection deckCollection) async {
    state = AsyncLoading();

    try {
      await ref.read(addDeckCollectionProvider(deckCollection).future);
      final deckCollections = await _getDeckCollections();

      state = AsyncData(deckCollections);
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> deleteDeckCollection(String collectionId) async {
    state = AsyncLoading();

    try {
      await ref.read(deleteDeckCollectionProvider(collectionId).future);
      final deckCollections = await _getDeckCollections();

      state = AsyncData(deckCollections);
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> addDeckToCollection(
      Deck deck, String collectionId, String path) async {
    try {
      final notifier =
          ref.read(deckCollectionNotifierProvider(collectionId).notifier);
      await notifier.addDeckToCollection(deck, path);

      final deckCollections = await _getDeckCollections();

      state = AsyncData(deckCollections);
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<List<String>> _getDeckCollections() async {
    final collections = await ref.read(getAllDeckCollectionsProvider.future);
    return collections
        .map((e) => e.id!)
        .toList(); // TODO: Get this list from user.deckCollections instead!
  }
}

final deckCollectionListNotifierProvider =
    AsyncNotifierProvider<DeckCollectionListNotifier, List<String>>(() {
  return DeckCollectionListNotifier();
});
