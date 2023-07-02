
import '../../custom/data/abstract/entity.dart';
import 'flashcard.dart';

class FlashcardResult extends Entity {

  final String flashcardId;
  final bool correct;
  final DateTime timestamp;

  FlashcardResult(super.id, this.flashcardId, this.correct, this.timestamp);
  
  @override
  Map<String, dynamic> serialized() {
    return {'flashcardId' : flashcardId, 'correct' : correct, 'timestamp' : timestamp};
  }
  
  @override
  bool isEqualTo(Entity other) {
    if(other is FlashcardResult)
    {
      return flashcardId == other.flashcardId 
        && correct == other.correct 
        && timestamp == other.timestamp;
    }
    return false;
  }
}
