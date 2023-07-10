
import 'package:firedart/firestore/models.dart';

import '../../custom/data/abstract/database_service.dart';
import '../../custom/data/abstract/entity.dart';




import 'package:json_annotation/json_annotation.dart';
//part 'flashcard.g.dart';
@JsonSerializable()
class Flashcard extends Entity
{
  Flashcard(super.id, this.deckId, this.prompt, this.response);

  final String deckId;
  final String prompt;
  final String response;

  @override
  Map<String, dynamic> serialized() {
    return {'id' : id, 'deckId' : deckId, 'prompt' : prompt, 'response' : response};
  }

  static Flashcard deserialize(Map<String, dynamic> map) {
    return Flashcard(map['id'], map['deckId'], map['prompt'], map['response']);
  }
  
  @override
  bool isEqualTo(Entity other) {
    
    if(other is Flashcard)
    {
      return deckId == deckId 
        && prompt == other.prompt 
        && response == other.response;
    }
    return false;
  }
  

}

