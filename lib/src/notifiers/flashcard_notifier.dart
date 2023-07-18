import 'dart:async';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';
import 'package:flashcard_desktop_app/src/providers/flashcard_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../main.dart';
import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../services/app_data_service.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'flashcard_notifier.g.dart';

@Riverpod(keepAlive: true)
class FlashcardNotifier extends _$FlashcardNotifier {
  @override
  FutureOr<Flashcard> build(String arg) async {
    return await _getFlashcard(arg);
  }


  Future<Flashcard> _getFlashcard(String id) async {
    return await ref.read(getFlashcardByIdProvider(id).future);
  }

}