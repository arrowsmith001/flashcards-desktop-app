
import 'package:firedart/firestore/models.dart';

class Flashcard 
{
  Flashcard(this.id, this.prompt, this.response);

  final String id;
  final String prompt;
  final String response;
}

class FlashcardDirectory {
  FlashcardDirectory(this.id, this.path, this.depth);
  
  final String id;
  final String path;
  final int depth;

  final List<FlashcardDirectory> childDirectories = [];
  final List<Flashcard> childFlashcards = [];

  static FlashcardDirectory fromFirestoreDocument(Document doc) {
    return FlashcardDirectory(doc.id, doc['path'], doc['depth']);
  }
}