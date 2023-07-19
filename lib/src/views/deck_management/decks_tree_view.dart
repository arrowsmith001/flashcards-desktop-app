
import 'package:flashcard_desktop_app/src/custom/extensions/riverpod_extensions.dart';
import 'package:flashcard_desktop_app/src/custom/widgets/pathed_tree.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DecksTreeView extends ConsumerWidget {
  const DecksTreeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final id = ref.watch(getCurrentDeckCollectionIdProvider);
    final collectionAsync = ref.watch(deckCollectionNotifierProvider(id));

    return collectionAsync.whenDefault((collection) {
      final deckIds = collection.deckIds;

      if (deckIds.isEmpty) {
        return Center(
          child: ElevatedButton(
              onPressed: () => onAddDeck(ref), child: Text('Add Deck')),
        );
      }

      return PathedTree<String>(collection.deckIds,
          getPath: (id) => collection.deckIdsToPaths[id]!,
          buildNode: (context, path, deckIdMaybe) {
            final isData = deckIdMaybe != null;

            final overrides = [getCurrentPathProvider.overrideWithValue(path)];
            if (isData) {
              overrides
                  .add(getCurrentDeckIdProvider.overrideWithValue(deckIdMaybe));
            }

            return ProviderScope(overrides: overrides, child: DeckTreeItem());
          });
    });
  }
  
  onAddDeck(WidgetRef ref) {}

/*   void onAddDeck(WidgetRef ref) {
/*     final r = Random();
    ref.read(addDeckProvider(
        Deck(null, 'Deck ${r.nextInt(100)}', r.nextInt(1000), DateTime.now()))); */
  } */
}

class DeckTreeItem extends ConsumerWidget {
  const DeckTreeItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(title: Text('d?.name' ?? ' - '));
  }
}
