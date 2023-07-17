import 'dart:collection';

import 'entity.dart';

abstract class DatabaseService<T extends Entity> {
  Future<T> create(T item);
  Future<void> delete(String itemId);

  Future<List<T>> fetchAll();
  Future<T> fetchById(String id);
  Future<List<T>> fetchByIds(Iterable<String> ids);
  Future<List<T>> fetchWhere(String field, String value);
  Future<Map<String, List<T>>> fetchWhereMultiple(
      String field, Iterable<String> values);

  Stream<T>? streamById(String id);

  Future<void> setField(String itemId, String fieldName, value);

}

class EmptyDatabaseService<T extends Entity> extends DatabaseService<T> {
  @override
  Future<T> create(T item) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String itemId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<T>> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<T> fetchById(String id) {
    // TODO: implement fetchById
    throw UnimplementedError();
  }

  @override
  Future<List<T>> fetchByIds(Iterable<String> ids) {
    // TODO: implement fetchByIds
    throw UnimplementedError();
  }

  @override
  Future<List<T>> fetchWhere(String field, String value) {
    // TODO: implement fetchWhere
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<T>>> fetchWhereMultiple(
      String field, Iterable<String> values) {
    // TODO: implement fetchWhereMultiple
    throw UnimplementedError();
  }

  @override
  Future<void> setField(String itemId, String fieldName, value) {
    // TODO: implement setField
    throw UnimplementedError();
  }

  @override
  Stream<T>? streamById(String id) {
    // TODO: implement streamById
    throw UnimplementedError();
  }
  
}
