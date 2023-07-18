// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deck _$DeckFromJson(Map<String, dynamic> json) => Deck(
      json['id'] as String?,
      json['name'] as String?,
      (json['flashcards'] as List<dynamic>).map((e) => e as String).toList(),
      DateTime.parse(json['lastUpdatedTimestamp'] as String),
    );

Map<String, dynamic> _$DeckToJson(Deck instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'flashcards': instance.flashcards,
      'lastUpdatedTimestamp': instance.lastUpdatedTimestamp.toIso8601String(),
    };
