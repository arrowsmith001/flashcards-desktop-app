import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/repository.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck.dart';


class FakeDeckRepository extends Repository<Deck> {

  FakeDeckRepository() : super(EmptyDatabaseService());

  List<Deck> get _theDecks => [
        Deck('0', 'Deck_0', 3192, DateTime.now()),
        Deck('1', 'Deck_1', 234, DateTime.now()),
        Deck('2', 'Deck_2', 765, DateTime.now()),
        Deck('3', 'Deck_3', 213, DateTime.now()),
        Deck('4', 'Deck_4', 67, DateTime.now()),
        Deck('5', 'Deck_5', 23, DateTime.now()),
        Deck('6', 'Deck_6', 213, DateTime.now()),
      ];

  @override
  Future<Deck> createItem(Deck item) {
    // TODO: implement createItem
    throw UnimplementedError('createItem');
  }

  @override
  // TODO: implement databaseService
  DatabaseService<Deck> get databaseService => EmptyDatabaseService();

  @override
  Future<void> deleteItem(String itemId) {
    // TODO: implement deleteItem
    throw UnimplementedError('deleteItem');
  }

  @override
  Future<List<Deck>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError('getAll');
  }

  @override
  Future<Deck> getItemById(String id) async {
    return _theDecks.singleWhere((element) => element.id == id);
  }

  @override
  Future<List<Deck>> getItemsByField(String fieldName, String fieldValue) {
    // TODO: implement getItemsByField
    throw UnimplementedError('getItemsByField');
  }

  @override
  Future<List<Deck>> getItemsByIds(Iterable<String> itemIds) {
    // TODO: implement getItemsById
    throw UnimplementedError('getItemsByIds');
  }

  @override
  Future<void> setField(String itemId, String fieldName, value) {
    // TODO: implement setField
    throw UnimplementedError('setField');
  }

  @override
  Stream<Deck>? streamItemById(String id) {
    // TODO: implement streamItemById
    throw UnimplementedError('streamItemById');
  }
}
