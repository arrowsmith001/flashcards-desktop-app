import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/repository.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/model/entities/user.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/deck_collection_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';
import 'package:flashcard_desktop_app/src/services/app_data_service.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_service_providers.g.dart';

@Riverpod(keepAlive: true)
AppWindowManager windowManager(Ref ref) =>
    throw UnimplementedError('windowManager');

@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) =>
    throw UnimplementedError('appConfig');

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) =>
    throw UnimplementedError('authService');


@Riverpod(keepAlive: true)
Repository<User> userRepo(Ref ref) => throw UnimplementedError('userRepo');

@Riverpod(keepAlive: true)
Repository<Flashcard> flashcardRepo(Ref ref) => throw UnimplementedError('flashcardRepo');

@Riverpod(keepAlive: true)
Repository<Deck> deckRepo(Ref ref) => throw UnimplementedError('deckRepo');

@Riverpod(keepAlive: true)
Repository<DeckCollection> deckCollectionRepo(Ref ref) => throw UnimplementedError('deckCollectionRepo');

@Riverpod(keepAlive: true)
AppDataService dbService(Ref ref) => throw UnimplementedError();


