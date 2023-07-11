import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../model/entities/deck.dart';

final decksProvider =
    FutureProvider.family<List<Deck>, Iterable<String>>((ref, ids) async {
  final service = ref.watch(deckServiceProvider);
  return service.getDecksByIds(ids);
});

final fakeDecksProvider =
    FutureProvider.family<List<Deck>, Iterable<String>>((ref, arg) => [
          Deck('0', 'name 0', 0, DateTime.now()),
          Deck('1', 'name 1', 0, DateTime.now()),
          Deck('2', 'name 2', 0, DateTime.now())
        ]);
