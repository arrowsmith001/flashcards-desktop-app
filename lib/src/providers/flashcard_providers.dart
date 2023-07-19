import 'dart:async';
import 'dart:math';

import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
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
part 'flashcard_providers.g.dart';

@riverpod
Future<Flashcard> getFlashcardById(Ref ref, String flashcardId) async {
  final dbService = ref.watch(dbServiceProvider);
  return await dbService.getFlashcardById(flashcardId);
}