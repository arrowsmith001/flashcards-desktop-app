
import 'dart:collection';

import 'entity.dart';


abstract class DatabaseService<T extends Entity> 
{
  Future<List<T>> fetchAll();
  Future<T> fetchById(String id);
  Future<List<T>> fetchByIds(List<String> ids);
  Future<List<T>> fetchWhere(String field, String value);
  Future<Map<String, List<T>>> fetchWhereMultiple(String field, List<String> values);

  Stream<T> streamById(String id);

  Future<String?> add(T item);

  Future<void> setField(String itemId, String fieldName, value);
}

