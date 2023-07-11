import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../main.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../services/app_deck_service.dart';

final deckCollectionNotifierProvider = StateNotifierProvider<
    DeckCollectionListNotifier, AsyncValue<List<DeckCollection>>>((ref) {
  final deckCollectionService = ref.watch(deckServiceProvider);
  return DeckCollectionListNotifier(deckCollectionService);
});

final deckCollectionsProvider =
    Provider<AsyncValue<List<DeckCollection>>>((ref) {
  return ref.watch(deckCollectionNotifierProvider);
});

final addDeckCollectionProvider =
    Provider.family<Future<void>, DeckCollection>((ref, dc) async {
  final notifier = ref.read(deckCollectionNotifierProvider.notifier);
  return notifier.addDeckCollection(dc);
});

final deleteDeckCollectionProvider =
    Provider.family<Future<void>, DeckCollection>(
        (ref, deckCollectionId) async {
  final notifier = ref.read(deckCollectionNotifierProvider.notifier);
  return notifier.deleteDeckCollection(deckCollectionId);
});

class DeckCollectionListNotifier
    extends StateNotifier<AsyncValue<List<DeckCollection>>> {
  DeckCollectionListNotifier(this.deckService) : super(AsyncData([])) {
    getDeckCollections();
  }

  final AppDeckService deckService;

  Future<void> getDeckCollections() async {
    final collections = await deckService.getAllCollections();
    state = AsyncData(collections);
  }

  Future<void> addDeckCollection(DeckCollection deckCollection) async {
    await deckService.addDeckCollection(deckCollection);
    final collections = await deckService.getAllCollections();
    state = AsyncData(collections);
  }

  Future<void> deleteDeckCollection(DeckCollection dc) async {
    await deckService.deleteCollection(dc);
    final collections = await deckService.getAllCollections();
    state = AsyncData(collections);
  }
}

final deckCollectionProvider =
    FutureProvider.family<DeckCollection, String>((ref, id) async {
  final service = ref.watch(deckServiceProvider);
  return await service.getCollectionById(id);
});

final fakeDeckCollectionProvider =
    FutureProvider.family<DeckCollection, String>((ref, arg) => DeckCollection(
        'id', null, 'name', {'0': 'a', '1': 'a/b', '2': 'a/c'}, true));
