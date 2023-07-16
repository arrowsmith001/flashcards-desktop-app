import 'dart:math';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/extensions/riverpod_extensions.dart';
import 'package:flashcard_desktop_app/src/custom/widgets/pathed_tree.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flashcard_desktop_app/src/views/deck_management/deck_collection_browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../../main.dart';
import '../../model/entities/deck.dart';
import '../../model/entities/deck_collection.dart';
import '../../providers/deck_collection_providers.dart';
import '../../providers/deck_providers.dart';

  void onAddDeck(WidgetRef ref) async {
    final id = ref.read(getCurrentDeckCollectionIdProvider);

    final r = Random();
    final newDeck =
        Deck(null, 'Deck ${r.nextInt(100)}', r.nextInt(1000), DateTime.now());

    final notifier = ref.read(deckCollectionListNotifierProvider.notifier);
    final path = ref.read(getCurrentPathProvider);

    await notifier.addDeckToCollection(newDeck, id, path);
  }

// TODO: Make it so that I can navigate (and add data to) a pathed directory structure

class DeckBrowser extends ConsumerWidget {
  DeckBrowser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(getCurrentDeckCollectionIdProvider);
    final collection = ref.watch(deckCollectionNotifierProvider(id));

    return collection.whenDefault(data: (collection) {
      return Column(
        children: [
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.navigate_before)),
                  Flexible(
                      child: Text(
                    collection.name!,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
                  IconButton(
                      onPressed: () {
                        onAddDeck(ref);
                      },
                      icon: Icon(Icons.add))
                ],
              ),
              Flexible(
                child: DecksListView(),
              ),
            ],
          )),
        ],
      );
    });
  }
}

class DecksTreeView extends ConsumerWidget {
  const DecksTreeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(getCurrentDeckCollectionIdProvider);
    final collectionAsync = ref.watch(deckCollectionNotifierProvider(id));

    return collectionAsync.whenDefault(data: (collection) {
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

class DecksListView extends ConsumerWidget {
  const DecksListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(getCurrentDeckCollectionIdProvider);
    final collectionAsync = ref.watch(deckCollectionNotifierProvider(id));

    return collectionAsync.whenDefault(data: (collection) {

      final deckIds = collection.deckIds;
      if (deckIds.isEmpty) {
        return ElevatedButton(
            onPressed: () => onAddDeck(ref), child: Text('Add Deck'));
      }

      return ListView(
        children: deckIds
            .map((id) => ProviderScope(overrides: [
                  getCurrentPathProvider
                      .overrideWith((ref) => collection.deckIdsToPaths[id]!),
                  getCurrentDeckIdProvider.overrideWith((ref) => id),
                ], child: DecksListItem()))
            .toList(),
      );
    });
  }
}

class DecksListItem extends ConsumerWidget {
  const DecksListItem({
    super.key,
  });

/*   void onAddDeck(WidgetRef ref) {
    final path = ref.watch(getCurrentPathProvider);
    final deck = ref.watch(getCurrentDeckIdProvider);
    AppLogger.log(deck + " at " + path);
  } */

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(getCurrentPathProvider);
    final deck = ref.watch(getCurrentDeckIdProvider);

    return ListTile(
        title: Text(deck + " at " + path), onTap: () {});
  }
}
