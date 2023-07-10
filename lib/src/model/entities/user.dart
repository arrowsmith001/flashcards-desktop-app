
import '../../custom/data/abstract/entity.dart';

import 'package:json_annotation/json_annotation.dart';
//part 'user.g.dart';

@JsonSerializable()
class User extends Entity {
  final String name;
  final List<String> deckCollectionIds;

  static User deserialize(Map<String, dynamic> map) 
    => User(
      map['id'], 
      map['name'], 
      (map['deckCollectionIds'] as List).map((e) => e.toString()).toList());

  User(super.id, this.name, this.deckCollectionIds);
  
  @override
  Map<String, dynamic> serialized() {
    return {'id' : id, 
    'name' : name, 
    'deckCollectionIds' : deckCollectionIds};
  
  }

}