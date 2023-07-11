import 'dart:collection';

import 'entity.dart';

abstract class DatabaseService<T extends Entity> {
  Future<T> create(T item);
  Future<void> delete(T item);

  Future<List<T>> fetchAll();
  Future<T> fetchById(String id);
  Future<List<T>> fetchByIds(Iterable<String> ids);
  Future<List<T>> fetchWhere(String field, String value);
  Future<Map<String, List<T>>> fetchWhereMultiple(
      String field, Iterable<String> values);

  Stream<T>? streamById(String id);

  Future<void> setField(String itemId, String fieldName, value);
}
