import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/repository.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';

class FakeDeckCollectionRepository extends Repository<DeckCollection> {
  FakeDeckCollectionRepository() : super(EmptyDatabaseService());



  DeckCollection get _theCollection => DeckCollection(
      '0',
      null,
      'DC_0',
      {
        '0': 'a/b/c/d',
        '1': 'a/b/c/e',
        '2': 'a/b/c',
        '3': 'a/b/c',
        '4': 'a/b/c',
        '5': 'a/b/g',
        '6': 'a/b/c/h/i/j/k',
      },
      true);

  @override
  Future<DeckCollection> createItem(DeckCollection item) {
    throw UnimplementedError('createItem');
  }

  @override
  DatabaseService<DeckCollection> get databaseService => EmptyDatabaseService();

  @override
  Future<void> deleteItem(String itemId) {
    // TODO: implement deleteItem
    throw UnimplementedError('deleteItem');
  }

  @override
  Future<List<DeckCollection>> getAll() async {
    return [_theCollection];
  }

  @override
  Future<DeckCollection> getItemById(String id) async {
    if (id == '0') return _theCollection;
    throw UnimplementedError('getItemById');
  }

  @override
  Future<List<DeckCollection>> getItemsByField(
      String fieldName, String fieldValue) {
    // TODO: implement getItemsByField
    throw UnimplementedError('getItemsByField');
  }

  @override
  Future<List<DeckCollection>> getItemsByIds(Iterable<String> itemIds) {
    // TODO: implement getItemsById
    throw UnimplementedError('getItemsByIds');
  }

  @override
  Future<void> setField(String itemId, String fieldName, value) {
    // TODO: implement setField
    throw UnimplementedError('setField');
  }

  @override
  Stream<DeckCollection>? streamItemById(String id) {
    // TODO: implement streamItemById
    throw UnimplementedError('streamItemById');
  }
}
