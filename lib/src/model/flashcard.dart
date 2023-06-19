
class Flashcard 
{
  Flashcard(this.prompt, this.response);

  final String prompt;
  final String response;
}

class FlashcardDirectory {
  FlashcardDirectory(this.path, this.depth);

  final String path;
  final int depth;
}