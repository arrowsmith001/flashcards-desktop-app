import '../../custom/data/abstract/entity.dart';

import 'package:json_annotation/json_annotation.dart';
part 'deck.g.dart';

@JsonSerializable()
class Deck extends Entity {
  final String? name;
  List<String> flashcards = [];
  final DateTime lastUpdatedTimestamp;

  Deck(super.id, this.name, this.flashcards, this.lastUpdatedTimestamp);

  int get numberOfCards => flashcards.length;


  static Deck deserialize(Map<String, dynamic> map) => _$DeckFromJson(map);

  @override
  Entity deserializeInstance(Map<String, dynamic> map) => deserialize(map);
  
  @override
  Map<String, dynamic> serialized() => _$DeckToJson(this);
  
  @override
  Deck clone() {
    return Deck(id, name, flashcards, lastUpdatedTimestamp);
  }
  
  @override
  Deck cloneWithId(String newId) =>
      deserialize(serialized()..update('id', (value) => newId));
}

class PathedDeckId {
  final String deckId;
  final String path;

  PathedDeckId(this.deckId, this.path);
}
