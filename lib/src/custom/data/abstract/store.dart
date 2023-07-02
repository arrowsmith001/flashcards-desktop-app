import 'dart:collection';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';

import 'database_service.dart';
import 'entity.dart';

class Store<T extends Entity>
{
  Store(this.databaseService, {Iterable<T>? initialItems})
  {
    if(initialItems != null && initialItems.isNotEmpty)
    {
      itemIdsToItems.addAll(Map<String, T>.fromIterable(initialItems, key: (item) => item.id));
    }
  }

  final DatabaseService<T> databaseService;
  final HashMap<String, T> itemIdsToItems = HashMap();

  Future<T> getItemById(String id) async
  {
    if(itemIdsToItems.containsKey(id)) return itemIdsToItems[id]!;
    else {
      final T item = await databaseService.fetchById(id);
      itemIdsToItems.addAll({id : item});
      return item;
    }
  }

  Future<List<T>> getAll() async
  {
    final fetchedItems = await databaseService.fetchAll();
    _updateMap(fetchedItems);
    return fetchedItems;
  }

  Future<List<T>> getItemsByField(String fieldName, String fieldValue) async {
    
    final fetchedItems = await databaseService.fetchWhere(fieldName, fieldValue);
    _updateMap(fetchedItems); 
    return fetchedItems;
  }

  Future<bool> addItem(T item) async {
    
    final id = await databaseService.add(item);
    if(id != null){
      item.id = id;
      _updateMap([item]);
      return true;
    }
    return false;
  }
  
  void _updateMap(List<T> newItems) {
    int numberOfUpdates = 0;
    int numberAdded = 0;
    for(var item in newItems)
    {
      if(!itemIdsToItems.containsKey(item.id)){
        itemIdsToItems.addAll({item.id! : item});
        numberAdded++;
      }
      else
      {
        final existingItem = itemIdsToItems[item.id]!;
        if(!existingItem.isEqualTo(item))
        {
          itemIdsToItems.update(item.id!, (value) => item);
          numberOfUpdates++;
        }
      }
    }
    AppLogger.log('${newItems.length} items: $numberAdded new adds, $numberOfUpdates local updates');
  }

  void setField(String itemId, String fieldName, dynamic value) {
    databaseService.setField(itemId, fieldName, value);
  }
}



