import '../../custom/data/abstract/entity.dart';

import 'package:json_annotation/json_annotation.dart';
part 'deck.g.dart';

@JsonSerializable()
class Deck extends Entity {
  final String? name;
  final int numberOfCards;
  final DateTime lastUpdatedTimestamp;

  Deck(super.id, this.name, this.numberOfCards, this.lastUpdatedTimestamp);

  static Deck deserialize(Map<String, dynamic> map) => _$DeckFromJson(map);

  @override
  Map<String, dynamic> serialized() => _$DeckToJson(this);
}

class PathedDeckId {
  final String deckId;
  final String path;

  PathedDeckId(this.deckId, this.path);
}
