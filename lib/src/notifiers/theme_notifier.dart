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
import 'package:flashcard_desktop_app/src/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/entities/deck.dart';
import '../model/entities/deck_collection.dart';
import '../services/app_data_service.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_notifier.g.dart';

@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeData build() {
    return _getMainAppTheme;
  }

  void setFlashcardTheme() {
    state = FlashcardAppThemes.flashcardBaseTheme;
  }

  void setMainAppTheme() {
    state = _getMainAppTheme;
  }

  ThemeData get _getMainAppTheme => FlashcardAppThemes.defaultTheme;
}
