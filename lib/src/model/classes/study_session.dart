import 'dart:math';

import 'package:flashcard_desktop_app/src/model/entities/flashcard_result.dart';

class StudySession {
  StudySession(this._flashcardIds);

  final Random _rand = Random();

  final List<String> _flashcardIds;

  final List<String> _doneFlashcardIds = [];
  final List<String> _flashcardResultIds = [];

  Iterable<String> get flashcardResultIds => _flashcardResultIds;

  List<String> get _flashcardsToDoIds => _flashcardIds
      .where((flashcardId) => !_doneFlashcardIds.contains(flashcardId))
      .toList();

  String get getRandomUnseenFlashcardId {
    final flashcardsToDo = _flashcardsToDoIds;
    if (flashcardsToDo.isEmpty) throw Exception('flashcardsToDo is empty');
    final randInt = _rand.nextInt(flashcardsToDo.length);
    return flashcardsToDo[randInt];
  }

  int _numberCorrect = 0;

  int _numberIncorrect = 0;

  int get numberCorrect => _numberCorrect;

  int get numberIncorrect => _numberIncorrect;

  void logResult(FlashcardResult result) {
    _doneFlashcardIds.add(result.id!);
    _flashcardResultIds.add(result.id!);

    if (result.correct)
      _numberCorrect++;
    else
      _numberIncorrect++;
  }
}