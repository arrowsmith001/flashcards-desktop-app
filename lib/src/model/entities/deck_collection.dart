

import '../../custom/data/abstract/entity.dart';

class DeckCollection extends Entity {

  final String? creatorUserId;
  final String? name;
  final Map<String, dynamic>? deckIdsToPaths;
  final bool? isPrivate;

  static DeckCollection deserialize(Map<String, dynamic> map) => DeckCollection(map['id'], map['creatorUserId'], map['name'], map['deckIdsToPaths'], map['isPrivate']);

  DeckCollection(super.id, this.creatorUserId, this.name, this.deckIdsToPaths, this.isPrivate);


  @override
  Map<String, dynamic> serialized() {
    return {
      'creatorUserId' : creatorUserId, 
    'name' : name,
    'deckIdsToPaths' : deckIdsToPaths,
     'isPrivate' : isPrivate};
 
  }

}
