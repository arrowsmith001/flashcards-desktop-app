

import '../../custom/data/abstract/entity.dart';

class DeckCollection extends Entity {

  final String? creatorUserId;
  final String? name;
  final Map<String, String>? pathsToDeckIds;
  final bool? isPrivate;

  static DeckCollection deserialize(Map<String, dynamic> map) => 
    DeckCollection(map['id'], map['creatorUserId'], map['name'],
     (map['pathsToDeckIds'] as Map<String, dynamic>).map<String, String>((key, value) => MapEntry(key, value.toString())),
      map['isPrivate']);

  DeckCollection(super.id, this.creatorUserId, this.name, this.pathsToDeckIds, this.isPrivate);


  @override
  Map<String, dynamic> serialized() {
    return {
      'creatorUserId' : creatorUserId, 
    'name' : name,
    'pathsToDeckIds' : pathsToDeckIds,
     'isPrivate' : isPrivate};
 
  }

}
