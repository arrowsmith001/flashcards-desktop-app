import 'dart:async';
import 'dart:math';

import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard_result.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flashcard_desktop_app/src/services/app_data_service.dart';
import 'package:flashcard_desktop_app/src/views/deck_management/deck_collection_browser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../main.dart';
import '../model/entities/deck.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'flashcard_result_providers.g.dart';

@riverpod
Future<FlashcardResult> getFlashcardResultById(Ref ref, String flashcardResultId) async {
  final dbService = ref.watch(dbServiceProvider);
  return await dbService.getFlashcardResultById(flashcardResultId);
}