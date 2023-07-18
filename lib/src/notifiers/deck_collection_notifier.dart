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
import '../services/app_data_service.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'deck_collection_notifier.g.dart';

@Riverpod(keepAlive: true)
class DeckCollectionNotifier
    extends _$DeckCollectionNotifier {
  @override
  FutureOr<DeckCollection> build(String arg) async {
    return await _getDeckCollection(arg);
  }

  Future<void> addDeckToCollection(Deck deck, String path) async {
    try {
      final currentCollection = state.value!.clone();

      state = AsyncLoading();

      await ref.read(
          addDeckAndAddToCollectionProvider(deck, currentCollection, path).future);
      final deckCollection = await _getDeckCollection(currentCollection.id!);

      state = AsyncData(deckCollection);
    } on Exception catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<DeckCollection> _getDeckCollection(String id) async {
    return await ref.read(getDeckCollectionByIdProvider(id).future);
  }
}
