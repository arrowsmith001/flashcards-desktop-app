import 'dart:async';
import 'dart:convert';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../main.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../services/app_data_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_decks_list_notifier.g.dart';

@Riverpod(keepAlive: true)
class SelectedDecksListNotifier extends _$SelectedDecksListNotifier {
  @override
  List<String> build() {
    return [];
  }

  void toggleSelected(String deckId) {
    final newList = List<String>.from(state);

    if (newList.contains(deckId))
      newList.remove(deckId);
    else
      newList.add(deckId);
    AppLogger.log(newList);
    state = newList;
  }
}
