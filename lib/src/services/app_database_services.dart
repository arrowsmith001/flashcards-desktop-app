


import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:flutter/material.dart';

import '../classes/app_config.dart';
import '../custom/data/abstract/entity.dart';
import '../custom/data/abstract/entity_service.dart';
import '../custom/data/abstract/repository.dart';
import '../custom/data/implemented/firebase.dart';
import '../model/entities/deck.dart';
import '../model/entities/user.dart';

abstract class AppDatabaseServices {
  AppDatabaseServices(this.userService, this.flashcardService, this.deckService, this.deckCollectionService, this.authService);

  Future<void> initialize(AppConfig config);

  final DatabaseService<User> userService;
  final DatabaseService<Flashcard> flashcardService;
  final DatabaseService<Deck> deckService;
  final DatabaseService<DeckCollection> deckCollectionService;
  final AuthService authService;
}




