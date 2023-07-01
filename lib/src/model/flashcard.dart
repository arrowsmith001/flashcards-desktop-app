
import 'package:firedart/firestore/models.dart';

import '../custom/data/database_service.dart';
import '../custom/data/serializable.dart';





class Flashcard extends Serializable
{
  Flashcard(super.id, this.prompt, this.response);

  final String prompt;
  final String response;

  @override
  Map<String, dynamic> serialized() {
    return {'id' : id, 'prompt' : prompt, 'response' : response};
  }

  static Flashcard deserialize(Map<String, dynamic> map) {
    return Flashcard(map['id'], map['prompt'], map['response']);
  }
  

}


class FlashcardDirectory extends Serializable {
  FlashcardDirectory(super.id, this.path, this.depth);
  
  final String path;
  final int depth;

  final List<Flashcard> childFlashcards = [];

  String get name => path.split('/').last;

  static FlashcardDirectory deserialize(Map<String, dynamic> map) {
    return FlashcardDirectory(map['id'], map['path'], map['depth']);
  }
  
  @override
  Map<String, dynamic> serialized() {
    return {'id' : id, 'path' : path, 'depth' : depth};
  }

}

class FlashcardResult extends Serializable {

  final Flashcard flashcard;
  final bool correct;
  final DateTime timestamp;

  FlashcardResult(super.id, this.flashcard, this.correct, this.timestamp);
  
  @override
  Map<String, dynamic> serialized() {
    return {'flashcardId' : flashcard.id, 'correct' : correct, 'timestamp' : timestamp};
  }
}
