import 'package:flashcard_desktop_app/src/model/entities/deck.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state_providers.g.dart';

/* final getCurrentDeckCollectionIdProvider =
    Provider<String>(getCurrentDeckCollectionId); */
@Riverpod(keepAlive: true)
String getCurrentDeckCollectionId(Ref ref) =>
    throw UnimplementedError('getCurrentDeckCollectionId');

@Riverpod(keepAlive: true)
String getCurrentDeckId(Ref ref) =>
    throw UnimplementedError('getCurrentDeckId');

@Riverpod(keepAlive: true)
String getCurrentFlashcardId(Ref ref) =>
    throw UnimplementedError('getCurrentFlashcardId');

@Riverpod(keepAlive: true)
String getCurrentPath(Ref ref) => throw UnimplementedError('getCurrentPath');

@Riverpod(keepAlive: true)
List<String> getCurrentlySelectedDeckIds(Ref ref) => [];
