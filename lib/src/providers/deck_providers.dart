import 'dart:async';
import 'dart:math';

import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flashcard_desktop_app/src/services/app_data_service.dart';
import 'package:flashcard_desktop_app/src/views/deck_management/deck_collection_browser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';
import 'package:flashcard_desktop_app/src/providers/app_service_providers.dart';

import '../../main.dart';
import '../model/entities/deck.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'deck_providers.g.dart';

/* final getAllDecksProvider = FutureProvider.autoDispose
    .family<List<Deck>, String>((ref, userId) async {
  final dbService = ref.watch(dbServiceProvider);
  final r = await dbService.getAllCollections();
  return r;
}); */

@riverpod
Future<List<Deck>> getDecksByIds(Ref ref, List<String> deckIds) async {
  final dbService = ref.watch(dbServiceProvider);
  return await dbService.getDecksByIds(deckIds);
}

@riverpod
Future<Deck> getDeckById(Ref ref, String deckId) async {
  final dbService = ref.watch(dbServiceProvider);
  return await dbService.getDeckById(deckId);
}


