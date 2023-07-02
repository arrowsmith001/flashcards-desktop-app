import 'entity.dart';
import 'store.dart';

abstract class EntityService<T extends Entity> 
{
  EntityService(this.entityStore); 

  final Store<T> entityStore;
}