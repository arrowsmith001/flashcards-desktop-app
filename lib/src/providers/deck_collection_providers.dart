import 'dart:async';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../main.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../services/app_data_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'deck_collection_providers.g.dart';

@riverpod
Future<DeckCollection> addDeckCollection(
    Ref ref, DeckCollection deckCollection) async {
  final dbService = ref.watch(dbServiceProvider);
  return await dbService.addDeckCollection(deckCollection);
}

@riverpod
Future<List<DeckCollection>> getAllDeckCollections(Ref ref) async {
  final dbService = ref.watch(dbServiceProvider);
  return await dbService.getAllDeckCollections();
}

@riverpod
Future<List<DeckCollection>> getDeckCollectionsByIds(
    Ref ref, List<String> ids) async {
  final dbService = ref.watch(dbServiceProvider);
  return await dbService.getAllDeckCollections(); // TODO: Use argument
}

@riverpod
Future<DeckCollection> getDeckCollectionById(Ref ref, String id) async {
  final dbService = ref.watch(dbServiceProvider);
  return await dbService.getDeckCollectionById(id);
}

@riverpod
Future<void> deleteDeckCollection(Ref ref, String deckCollectionId) async {
  final dbService = ref.watch(dbServiceProvider);
  await dbService.deleteCollection(deckCollectionId);
}

@riverpod
Future<void> addDeckAndAddToCollection(
    Ref ref, Deck deck, DeckCollection deckCollection, String path) async {
  final dbService = ref.watch(dbServiceProvider);

  final deckWithId = await dbService.addDeck(deck);
  await dbService.addDeckToCollection(deckWithId, deckCollection, path);
}

@riverpod
DeckCollection getFakeDeckCollection(Ref ref) => DeckCollection(
    'id', null, 'name', {'0': 'a', '1': 'a/b', '2': 'a/c'}, true);
