import 'dart:math';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/extensions/riverpod_extensions.dart';
import 'package:flashcard_desktop_app/src/custom/widgets/pathed_tree.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/selected_decks_list_notifier.dart';
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

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

void onAddDeck(WidgetRef ref) async {
  final id = ref.read(getCurrentDeckCollectionIdProvider);

  final r = Random();
  final newDeck =
      Deck(null, 'Deck ${r.nextInt(100)}', r.nextInt(1000), DateTime.now());

  final notifier = ref.read(deckCollectionListNotifierProvider.notifier);
  final path = ref.read(getCurrentPathProvider);

  await notifier.addDeckToCollection(newDeck, id, path);
}

void onAddSubfolder(WidgetRef ref, String folderName) async {
/*   final id = ref.read(getCurrentDeckCollectionIdProvider);
  final notifier = ref.read(deckCollectionListNotifierProvider.notifier);
  final path = ref.read(getCurrentPathProvider);

  await notifier.addDeckToCollection(newDeck, id, path); */
}

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
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.navigate_before)),
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                    collection.name!,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )],)),
                  IconButton(
                      onPressed: null,
                  /*                       onPressed: () {
                        onAddDeck(ref);
                      }, */
                      icon: Icon(Icons.add))
                ],
              ),
              Flexible(
                child: Navigator(
                  initialRoute: '',
                  onGenerateRoute: (settings) {
                    return MaterialPageRoute(
                        settings: settings,
                        builder: (context) {
                          return ProviderScope(overrides: [
                            getCurrentPathProvider
                                .overrideWithValue(settings.name!)
                          ], child: DecksListView());
                        });
                  },
                ),
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

// TODO: Figure out how to add a new Deck

class DecksListView extends ConsumerWidget {
  DecksListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colllectionId = ref.watch(getCurrentDeckCollectionIdProvider);
    final currentPath = ref.watch(getCurrentPathProvider);
    final collectionAsync =
        ref.watch(deckCollectionNotifierProvider(colllectionId));

    return collectionAsync.whenDefault(data: (collection) {
      // Paths to other folders
      final relativePathsFromHere =
          getRelativePathsFromPath(collection, currentPath);

      // Get unique subfolders
      final uniqueSubs = getUniqueSubfolderNames(relativePathsFromHere);

      // If there are deckIds at this path
      final deckIdsAtThisPath = getDeckIdsAtPath(collection, currentPath);

      // The edge case is at the beginning: if both are empty, initialize with new Deck/Path
      if (deckIdsAtThisPath.isEmpty && relativePathsFromHere.isEmpty) {
        return Column(
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () => onAddDeck(ref),
                  child: Text('Add First Deck')),
            ),
            Expanded(
              child: TextButton(
                  onPressed: () => onAddSubfolder(ref, getRandomString(10)),
                  child: Text('Add Subfolder')),
            ),
          ],
        );
      }

      // For navigation
      final allDestinations = <String>[''];
      String lastDestination = '';
      if (currentPath != '') {
        if (!currentPath.contains('/')) {
          allDestinations.add(currentPath);
          lastDestination = currentPath;
        } else {
          lastDestination = currentPath.split('/').fold<String>('',
              (builtUpPath, folderName) {
            if (builtUpPath == '')
              return folderName;
            else
              allDestinations.add(builtUpPath);
            return [builtUpPath, folderName].join('/');
          });
          allDestinations.add(lastDestination);
        }
      }

      return Column(
        children: [
          Row(children: [
            IconButton(
                onPressed: currentPath == ""
                    ? null
                    : () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back)),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: allDestinations
                  .map<Widget>((dest) => dest == ''
                      ? IconButton(
                          onPressed: dest == lastDestination
                              ? null
                              : () => Navigator.of(context)
                                  .popUntil(ModalRoute.withName('')),
                          icon: Icon(Icons.home))
                      : Wrap(
                          children: [
                            Text(
                              '>',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            TextButton(
                                onPressed: dest == lastDestination
                                    ? null
                                    : () => Navigator.of(context)
                                        .popUntil(ModalRoute.withName(dest)),
                                child: Text(!dest.contains('/')
                                    ? dest
                                    : dest.split('/').last))
                          ],
                        ))
                  .toList(),
            )
          ]),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: uniqueSubs
                      .map((sub) => ProviderScope(overrides: [
                            getCurrentPathProvider.overrideWith((ref) =>
                                currentPath == '' ? sub : '$currentPath/$sub'),
                          ], child: DeckSubPathListItem()))
                      .toList(),
                ),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: deckIdsAtThisPath
                      .map((deckId) => ProviderScope(overrides: [
                            getCurrentDeckIdProvider.overrideWithValue(deckId),
                          ], child: DeckEntryListItem()))
                      .toList(),
                ),
              ),
            ],
          )),
        ],
      );
    });
  }

  List<String> getUniqueSubfolderNames(
          Iterable<String> relativePathsFromHere) =>
      relativePathsFromHere.map((e) => e.split('/').first).toSet().toList();

  Iterable<String> getRelativePathsFromPath(
      DeckCollection collection, String currentPath) {
    return collection.paths.where((path) {
      return path != currentPath && path.startsWith(currentPath);
    }).map((fullPath) =>
        fullPath.replaceFirst(currentPath == '' ? '' : '$currentPath/', ''));
  }

  Iterable<String> getDeckIdsAtPath(
      DeckCollection collection, String currentPath) {
    return collection.deckIds.where((id) {
      final deckPath = collection.deckIdsToPaths[id];
      return (deckPath == currentPath);
    });
  }
}

class DeckSubPathListItem extends ConsumerWidget {
  DeckSubPathListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(getCurrentPathProvider);
    final name = path.split('/').last;
    //final deck = ref.watch(getCurrentDeckIdProvider);

    return InkWell(
        onTap: () => onPressed(context, path),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.folder_outlined), Text(name)],
          ),
        )));
  }

  void onPressed(BuildContext context, String arg) {
    Navigator.of(context).pushNamed(arg);
  }
}

// TODO: Allow going into Deck edit view
class DeckEntryListItem extends ConsumerWidget {
  DeckEntryListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(getCurrentPathProvider);
    final deckId = ref.watch(getCurrentDeckIdProvider);
    final selectedDeckIds = ref.watch(getCurrentlySelectedDeckIdsProvider);

    final deckNotifier = ref.watch(deckNotifierProvider(deckId));

    return deckNotifier.whenDefault(data: (deck) {
      final selectedNotifier =
          ref.watch(selectedDecksListNotifierProvider.notifier);
      final selected = ref.watch(selectedDecksListNotifierProvider);

      return ListTile(
          onTap: () => selectedNotifier.toggleSelected(deckId),
          leading: Icon(Icons.file_copy),
          title: Text(deck.name! + ', ${deck.numberOfCards} cards'),
          trailing: Checkbox(
            value: selected.contains(deckId),
            onChanged: (bool? value) {
              selectedNotifier.toggleSelected(deckId);
            },
          ));
    });
  }
}
