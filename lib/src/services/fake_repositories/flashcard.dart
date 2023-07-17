import 'dart:math';

import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/repository.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';

class FakeFlashcardRepository extends Repository<Flashcard> {
  
  FakeFlashcardRepository() : super(EmptyDatabaseService()) {
    _theFlashcards = List.generate(500, (i) {
      final r = Random();
      return Flashcard('$i', '${r.nextInt(6)}', 'prompt $i', 'response $i');
    });
  }

  late List<Flashcard> _theFlashcards;

  @override
  Future<Flashcard> createItem(Flashcard item) {
    // TODO: implement createItem
    throw UnimplementedError();
  }

  @override
  // TODO: implement databaseService
  DatabaseService<Flashcard> get databaseService => throw UnimplementedError();

  @override
  Future<void> deleteItem(String itemId) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<List<Flashcard>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Flashcard> getItemById(String id) {
    // TODO: implement getItemById
    throw UnimplementedError();
  }

  @override
  Future<List<Flashcard>> getItemsByField(String fieldName, String fieldValue) {
    // TODO: implement getItemsByField
    throw UnimplementedError();
  }

  @override
  Future<List<Flashcard>> getItemsByIds(Iterable<String> itemIds) {
    // TODO: implement getItemsByIds
    throw UnimplementedError();
  }

  @override
  Future<void> setField(String itemId, String fieldName, value) {
    // TODO: implement setField
    throw UnimplementedError();
  }

  @override
  Stream<Flashcard>? streamItemById(String id) {
    // TODO: implement streamItemById
    throw UnimplementedError();
  }
}
