import '../../custom/data/abstract/entity.dart';

class Deck extends Entity {
  
  final String? name;
  final int numberOfCards;
  final DateTime lastUpdatedTimestamp;

  Deck(super.id, this.name, this.numberOfCards, 
  this.lastUpdatedTimestamp
  );

  static Deck deserialize(Map<String, dynamic> map) {
    return Deck(map['id'], map['name'], map['numberOfCards'], 
    
    map['lastUpdatedTimestamp']
    
    );
  }
  
  @override
  Map<String, dynamic> serialized() {
    return {'id' : id, 
    'name' : name, 
    'numberOfCards' : numberOfCards,
    'lastUpdatedTimestamp' : lastUpdatedTimestamp
    };
  }
  

}