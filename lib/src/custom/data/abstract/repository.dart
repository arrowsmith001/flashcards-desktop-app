import 'dart:async';
import 'dart:collection';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flutter/material.dart';

import 'database_service.dart';
import 'entity.dart';

class Repository<T extends Entity>
{
  
  Repository(this.databaseService, {Iterable<T>? initialItems})
  {
    if(initialItems != null && initialItems.isNotEmpty)
    {
      cache.cacheAll(initialItems);
    }
  }

  Cache<T> cache = Cache();
  int get cacheCount => cache.count;

  final DatabaseService<T> databaseService;

  Stream<T>? streamItemById(String id){
    return databaseService.streamById(id)?.map((item) {
      cache.cache(item);
      return item;
    });
     
  }


  Future<T?> getItemById(String id) async
  {
    if(cache.contains(id)) return cache.get(id)!;
    final T? entity = await databaseService.fetchById(id);
    if(entity == null) return null;
    cache.cache(entity);
    return entity;
  }

  Future<List<T>> getAll() async
  {
    final fetchedItems = await databaseService.fetchAll();
    cache.cacheAll(fetchedItems);
    return fetchedItems;
  }

  Future<List<T>> getItemsByField(String fieldName, String fieldValue) async {
    
    final fetchedItems = await databaseService.fetchWhere(fieldName, fieldValue);
    cache.cacheAll(fetchedItems);
    return fetchedItems;
  }

  Future<T?> createItem(T item) async {
    
    final id = await databaseService.add(item);
    if(id != null){
      item.id = id;
      cache.cache(item);
      return item;
    }
    return null;
  }
  


  void setField(String itemId, String fieldName, dynamic value) async {
    await databaseService.setField(itemId, fieldName, value);
    final updatedItem = await databaseService.fetchById(itemId);
    cache.cache(updatedItem);
  }

  Future<List<T>> getItemsById(List<String> itemIds) async {
    final cachedItems = cache.getAsMany(itemIds);
    final cachedItemIds = cachedItems.map((e) => e.id);

    final uncachedItems = await databaseService.fetchByIds(itemIds.where((element) => !cachedItemIds.contains(element)));
    cache.cacheAll(uncachedItems);

    cachedItems.addAll(uncachedItems);
    return cachedItems;
  }
}

class Cache<T extends Entity> 
{

  final HashMap<String, T> itemIdsToItems = HashMap();

  get count => itemIdsToItems.length;

  T? get(String id){
    return itemIdsToItems[id];
  }

  bool contains(String id) => itemIdsToItems.containsKey(id);

  void cache(T? entity){
    if(entity == null || entity.id == null) return;
    if(contains(entity.id!)) itemIdsToItems.update(entity.id!, (_) => entity);
    else itemIdsToItems.addAll({entity.id! : entity});
  }
  
  void cacheAll(Iterable<T> entities) {
    for(var entity in entities)
    {
      cache(entity);
    }
  }
  
  List<T> getAsMany(List<String> itemIds) {
    return itemIds.where((element) => contains(element))
      .map((e) => get(e)!).toList();
  }
}



