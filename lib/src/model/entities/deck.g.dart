// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deck _$DeckFromJson(Map<String, dynamic> json) => Deck(
      json['id'] as String?,
      json['name'] as String?,
      json['numberOfCards'] as int,
      DateTime.parse(json['lastUpdatedTimestamp'] as String),
    );

Map<String, dynamic> _$DeckToJson(Deck instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'numberOfCards': instance.numberOfCards,
      'lastUpdatedTimestamp': instance.lastUpdatedTimestamp.toIso8601String(),
    };
