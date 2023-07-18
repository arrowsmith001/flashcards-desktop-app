
import '../../custom/data/abstract/entity.dart';

import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User extends Entity {
  
  User(super.id, this.name, this.deckCollectionIds);

  final String name;
  final List<String> deckCollectionIds;

  static User deserialize(Map<String, dynamic> map) 
    => User(
      map['id'], 
      map['name'], 
      (map['deckCollectionIds'] as List).map((e) => e.toString()).toList());

  
  
  @override
  Map<String, dynamic> serialized() {
    return {'id' : id, 
    'name' : name, 
    'deckCollectionIds' : deckCollectionIds};
  
  }
  
  @override
  User clone() {
    return User(id, name, deckCollectionIds);
  }

  @override
  User cloneWithId(String newId) =>
      deserialize(serialized()..update('id', (value) => newId));
}