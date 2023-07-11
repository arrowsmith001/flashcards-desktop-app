import 'package:json_annotation/json_annotation.dart';
import 'package:riverpod/src/common.dart';

import '../../custom/data/abstract/entity.dart';
import 'deck.dart';
//part 'deck_collection.g.dart';

@JsonSerializable()
class DeckCollection extends Entity {
  final String? creatorUserId;
  final String? name;
  final Map<String, String>? pathsToDeckIds; // TODO: Refactor to decksToPathIds
  final bool? isPrivate;

  static DeckCollection deserialize(Map<String, dynamic> map) => DeckCollection(
      map['id'],
      map['creatorUserId'],
      map['name'],
      (map['pathsToDeckIds'] as Map<String, dynamic>)
          .map<String, String>((key, value) => MapEntry(key, value.toString())),
      map['isPrivate']);

  DeckCollection(super.id, this.creatorUserId, this.name, this.pathsToDeckIds,
      this.isPrivate);

  @override
  Map<String, dynamic> serialized() {
    return {
      //'id': id,
      'creatorUserId': creatorUserId,
      'name': name,
      'pathsToDeckIds': pathsToDeckIds,
      'isPrivate': isPrivate
    };
  }
}
