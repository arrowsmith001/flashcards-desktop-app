import 'dart:convert';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/database_service.dart';
import 'package:flashcard_desktop_app/src/model/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../abstract/auth_service.dart';
import '../abstract/entity.dart';

class LocalJSONDatabaseService<T extends Entity> implements DatabaseService<T> {
  final Database database;
  final String tableName;
  final T Function(Map<String, dynamic>) deserializeDocument;

  LocalJSONDatabaseService(
      this.database, this.tableName, this.deserializeDocument);

  @override
  Future<T> create(T item) async {
    final id = await database.rawInsert(
        "INSERT INTO $tableName(json) VALUES('${jsonEncode(item.serialized())}')");
    final query =
        await database.rawQuery('SELECT * FROM $tableName WHERE id=$id');
    final single = query.single;
    final fullMap = <String, dynamic>{}
      ..addAll(jsonDecode(single['json'].toString()))
      ..addAll({'id': single['id'].toString()});
    return deserializeDocument(fullMap);
  }

  @override
  Future<List<T>> fetchAll() async {
    List<Map<String, dynamic>> queryList =
        await database.rawQuery('SELECT * FROM $tableName');
    try {
      List<Map<String, dynamic>> list = queryList
          .map((q) => (jsonDecode(q['json']) as Map<String, dynamic>)
            ..addAll({'id': q['id'].toString()}))
          .toList();
      return list.map<T>(deserializeDocument).toList();
    } catch (e) {
      AppLogger.log(e);
    }

    return [];
  }

  @override
  Future<T> fetchById(String id) {
    // TODO: implement fetchById
    throw UnimplementedError();
  }

  @override
  Future<List<T>> fetchByIds(Iterable<String> ids) async {
    List<Map<String, dynamic>> queryList = await database
        .rawQuery('SELECT * FROM $tableName WHERE id in (${ids.join(',')})');

    try {
      List<Map<String, dynamic>> list = queryList
          .map((q) => (jsonDecode(q['json']) as Map<String, dynamic>)
            ..addAll({'id': q['id'].toString()}))
          .toList();
      return list.map<T>(deserializeDocument).toList();
    } catch (e) {
      AppLogger.log(e);
    }

    return [];
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
    return database
        .rawQuery('SELECT 1 FROM $tableName WHERE id = $id')
        .then((value) {
      List<String> jsonList = value.map((e) => e['json'].toString()).toList();
      List<Map<String, dynamic>> list =
          jsonList.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
      return list.map<T>(deserializeDocument).toList().single;
    }).asStream();
  }

  @override
  Future<void> delete(T item) async {
    final count = await database
        .rawDelete('DELETE FROM $tableName WHERE id = ${item.id}');
  }
}

class LocalMockAuthService extends AuthService {
  LocalMockAuthService(Database database, this.userService);

  DatabaseService<User> userService;

  @override
  Future<String?> getLoggedInId() async {
    return '';
  }

  @override
  Future<bool> isLoggedIn() async {
    return true;
  }

  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    AppLogger.log('Logging in w/ email and pw');
  }
}
