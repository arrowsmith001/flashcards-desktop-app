import '../../custom/data/abstract/entity.dart';
import 'flashcard.dart';

import 'package:json_annotation/json_annotation.dart';

part 'flashcard_result.g.dart';

@JsonSerializable()
class FlashcardResult extends Entity {
  final String flashcardId;
  final bool correct;
  final DateTime timestamp;

  FlashcardResult(super.id, this.flashcardId, this.correct, this.timestamp);

  @override
  Map<String, dynamic> serialized() {
    return _$FlashcardResultToJson(this);
  }

  static FlashcardResult deserialize(Map<String, dynamic> map) =>
      _$FlashcardResultFromJson(map);

  @override
  bool isEqualTo(Entity other) {
    if (other is FlashcardResult) {
      return flashcardId == other.flashcardId &&
          correct == other.correct &&
          timestamp == other.timestamp;
    }
    return false;
  }

  @override
  FlashcardResult clone() {
    return FlashcardResult(id, flashcardId, correct, timestamp);
  }


  @override
  FlashcardResult cloneWithId(String newId) =>
      deserialize(serialized()..update('id', (value) => newId));
}
