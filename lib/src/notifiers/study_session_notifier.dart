import 'dart:async';
import 'dart:math';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/repository.dart';
import 'package:flashcard_desktop_app/src/model/classes/study_session.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard_result.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';
import 'package:flashcard_desktop_app/src/providers/flashcard_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../main.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../services/app_data_service.dart';

import 'package:flashcard_desktop_app/src/providers/app_service_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'study_session_notifier.g.dart';



@Riverpod(keepAlive: true)
class StudySessionNotifier extends _$StudySessionNotifier {
  // TODO: Handle null check exception
  String get getRandomUnseenFlashcardId =>
      state.value!.getRandomUnseenFlashcardId;

  @override
  FutureOr<StudySession> build(List<String> arg) async {
    final futures = List.generate(
        arg.length, (i) => ref.read(deckNotifierProvider(arg[i]).future));
    final decks = await Future.wait(futures);

    final flashcardIds = decks.expand((deck) => deck.flashcards);

    return StudySession(flashcardIds.toList());
  }

  Future<void> addDeck(String deckId, String path) async {
    throw UnimplementedError();
    //state = AsyncLoading();
  }

  Future<Flashcard>? _getFlashcard(String id) {
    //return await ref.read(getFlashcardByIdProvider(id).future);
  }

  void logResult(FlashcardResult flashcardResult) async {
    final dbService = ref.read(dbServiceProvider);

    final FlashcardResult resultWithId = await
        dbService.addFlashcardResult(flashcardResult);

    state.value!.logResult(resultWithId);

    state = state;
  }
}
