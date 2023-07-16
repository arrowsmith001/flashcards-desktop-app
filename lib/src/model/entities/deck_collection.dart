import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod/src/common.dart';

import '../../custom/data/abstract/entity.dart';
import 'deck.dart';
part 'deck_collection.g.dart';

@JsonSerializable()
class DeckCollection extends Entity {
  static String PATHS_TO_DECK_IDS = 'deckIdsToPaths';

  final String? creatorUserId;
  final String? name;
  final Map<String, String> deckIdsToPaths; // TODO: Refactor to decksToPathIds
  final bool? isPrivate;

  static DeckCollection deserialize(Map<String, dynamic> map) =>
      _$DeckCollectionFromJson(map);

  DeckCollection(super.id, this.creatorUserId, this.name, this.deckIdsToPaths,
      this.isPrivate);

  @override
  Map<String, dynamic> serialized() {
    return _$DeckCollectionToJson(this);
  }

  List<String> get deckIds => deckIdsToPaths.keys.toList();

  static DeckCollection copyFrom(DeckCollection original) {
    return DeckCollection(original.id, original.creatorUserId, original.name,
        original.deckIdsToPaths, original.isPrivate);
  }
}
