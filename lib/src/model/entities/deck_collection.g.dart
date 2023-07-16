// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeckCollection _$DeckCollectionFromJson(Map<String, dynamic> json) =>
    DeckCollection(
      json['id'] as String?,
      json['creatorUserId'] as String?,
      json['name'] as String?,
      Map<String, String>.from(json['deckIdsToPaths'] as Map),
      json['isPrivate'] as bool?,
    );

Map<String, dynamic> _$DeckCollectionToJson(DeckCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creatorUserId': instance.creatorUserId,
      'name': instance.name,
      'deckIdsToPaths': instance.deckIdsToPaths,
      'isPrivate': instance.isPrivate,
    };
