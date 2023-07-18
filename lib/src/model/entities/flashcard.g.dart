// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flashcard _$FlashcardFromJson(Map<String, dynamic> json) => Flashcard(
      json['id'] as String?,
      json['deckId'] as String,
      json['prompt'] as String,
      json['response'] as String,
    );

Map<String, dynamic> _$FlashcardToJson(Flashcard instance) => <String, dynamic>{
      'id': instance.id,
      'deckId': instance.deckId,
      'prompt': instance.prompt,
      'response': instance.response,
    };
