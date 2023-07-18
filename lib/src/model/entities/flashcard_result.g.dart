// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashcardResult _$FlashcardResultFromJson(Map<String, dynamic> json) =>
    FlashcardResult(
      json['id'] as String?,
      json['flashcardId'] as String,
      json['correct'] as bool,
      DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$FlashcardResultToJson(FlashcardResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'flashcardId': instance.flashcardId,
      'correct': instance.correct,
      'timestamp': instance.timestamp.toIso8601String(),
    };
