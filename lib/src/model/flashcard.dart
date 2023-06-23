
import 'package:firedart/firestore/models.dart';

abstract class Serializable {
  Map<String, dynamic> serialized();
}

class Flashcard implements Serializable
{
  Flashcard(this.id, this.prompt, this.response);

  final String id;
  final String prompt;
  final String response;

  @override
  Map<String, dynamic> serialized() {
    return {'id' : id, 'prompt' : prompt, 'response' : response};
  }

  static Flashcard deserialized(Map<String, dynamic> map) {
    return Flashcard(map['id']!, map['prompt']!, map['response']!);
  }
}

class FlashcardDirectory {
  FlashcardDirectory(this.id, this.path, this.depth);
  
  final String id;
  final String path;
  final int depth;

  final List<FlashcardDirectory> childDirectories = [];
  final List<Flashcard> childFlashcards = [];

  String get name => path.split('/').last;

  static FlashcardDirectory fromFirestoreDocument(Document doc) {
    return FlashcardDirectory(doc.id, doc['path'], doc['depth']);
  }

}

