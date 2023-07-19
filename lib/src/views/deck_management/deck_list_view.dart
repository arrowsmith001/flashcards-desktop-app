import 'package:flashcard_desktop_app/src/custom/extensions/riverpod_extensions.dart';
import 'package:flashcard_desktop_app/src/model/classes/deck_collection_navigation_helper.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck.dart';
import 'package:flashcard_desktop_app/src/notifiers/current_path_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/selected_decks_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Is this elegant? Maybe convert to stateful widgets for ref
// TODO: Consider extracting providers to getters

class DecksListView extends ConsumerWidget {
  DecksListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionId = ref.watch(getCurrentDeckCollectionIdProvider);
    final currentPath = ref.watch(getCurrentPathProvider);

    final collectionAsync =
        ref.watch(deckCollectionNotifierProvider(collectionId));

    return collectionAsync.whenDefault((collection) {
      final helper = DeckCollectionNavigationHelper(collection, currentPath);

      if (helper.isEmptyHere) {
        return _buildAddToEmptyPath(ref);
      }

      return Scaffold(
        body: Column(
          children: [
            _buildNavigationHeader(context, ref, helper),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: _buildSubfolders(helper),
                ),
                Flexible(
                  child: _buildListView(helper),
                ),
              ],
            )),
          ],
        ),
      );
    });
  }

  Widget _buildListView(DeckCollectionNavigationHelper helper) {
    return ListView(
      shrinkWrap: true,
      children: helper.deckIdsHere
          .map((deckId) => ProviderScope(overrides: [
                getCurrentDeckIdProvider.overrideWithValue(deckId),
              ], child: DeckEntryListItem()))
          .toList(),
    );
  }

  Widget _buildSubfolders(DeckCollectionNavigationHelper helper) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: helper.uniqueSubfolderNames
          .map((sub) => ProviderScope(overrides: [
                getCurrentPathProvider.overrideWith((ref) =>
                    helper.currentPath == ''
                        ? sub
                        : '${helper.currentPath}/$sub'),
              ], child: DeckSubPathListItem()))
          .toList(),
    );
  }

  Widget _buildNavigationHeader(BuildContext context, WidgetRef ref,
      DeckCollectionNavigationHelper helper) {
    return Row(children: [
      IconButton(
          onPressed:
              helper.currentPath == "" ? null : () => _navigateBackOne(ref),
          icon: Icon(Icons.arrow_back)),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: helper.allDestinationsUpToAndIncludingHere
            .map<Widget>((dest) => dest == ''
                ? IconButton(
                    onPressed: dest == helper.lastDestination
                        ? null
                        : () => _navigateBackTo(context, ref, ''),
                    icon: Icon(Icons.home))
                : Wrap(
                    children: [
                      Text(
                        '>',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      TextButton(
                          onPressed: dest == helper.lastDestination
                              ? null
                              : () => _navigateBackTo(context, ref, dest),
                          child: Text(!dest.contains('/')
                              ? dest
                              : dest.split('/').last))
                    ],
                  ))
            .toList(),
      )
    ]);
  }

  Widget _buildAddToEmptyPath(WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: TextButton(
              onPressed: () => onAddDeck(ref), child: Text('Add First Deck')),
        ),
        Expanded(
          child: TextButton(
              onPressed: () => onAddSubfolder(ref, 'Utils.getRandomString(10)'),
              child: Text('Add Subfolder')),
        ),
      ],
    );
  }

  onAddDeck(WidgetRef ref) {}

  onAddSubfolder(WidgetRef ref, String s) {}

  void _navigateBackOne(WidgetRef ref) {

  }

  void _navigateBackTo(BuildContext context, WidgetRef ref, String dest) {
    ref.read(currentPathNotifierProvider.notifier).setPath(dest);
    Navigator.of(context).popUntil(ModalRoute.withName(dest));
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

    return InkWell(
        onTap: () => _navigateTo(context, ref, path),
        child: Card(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [Icon(Icons.folder_outlined), Text(name)],
          ),
        )));
  }

  void _navigateTo(BuildContext context, WidgetRef ref, String path) {
    ref.read(currentPathNotifierProvider.notifier).setPath(path);
    Navigator.of(context).pushNamed(path);
  }
}

// TODO: Allow going into Deck edit view
class DeckEntryListItem extends ConsumerWidget {
  DeckEntryListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String deckId = ref.watch(getCurrentDeckIdProvider);
    final AsyncValue<Deck> deckNotifier =
        ref.watch(deckNotifierProvider(deckId));

    return deckNotifier.whenDefault((deck) {
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
