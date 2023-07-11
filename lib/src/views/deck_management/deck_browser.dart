import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/widgets/pathed_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../model/entities/deck.dart';
import '../../model/entities/deck_collection.dart';
import '../../providers/deck_collection_providers.dart';
import '../../providers/deck_providers.dart';

class DeckBrowser extends ConsumerStatefulWidget {
  final String collectionId;

  const DeckBrowser(this.collectionId, {super.key});

  @override
  ConsumerState<DeckBrowser> createState() => _DeckBrowserState();
}

class _DeckBrowserState extends ConsumerState<DeckBrowser> {
  String get collectionId => widget.collectionId;

  bool treeViewMode = true;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [],
      child: Builder(builder: (context) {
        final collectionAsync =
            ref.watch(deckCollectionWithDecksProvider(collectionId));

        return Column(
          children: [
            Expanded(
              child: collectionAsync.when(
                  data: (tuple) {
                    return Column(
                      children: [
                        _buildDeckBrowserTopRow(
                            context, tuple.item1, tuple.item2),
                        Flexible(
                          child: _buildDecksView(
                              context, tuple.item1, tuple.item2),
                        ),
                      ],
                    );
                  },
                  error: (e, _) => Text(e.toString()),
                  loading: () => CircularProgressIndicator(color: Colors.blue)),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDecksView(
      BuildContext context, DeckCollection collection, List<Deck> decks) {
    return treeViewMode
        ? _buildDecksTreeView(context, collection, decks)
        : _buildDecksListView(context, collection, decks);
  }

  Widget _buildDeckBrowserTopRow(
      BuildContext context, DeckCollection collection, List<Deck> decks) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Text(
          collection.name!,
          style: Theme.of(context).textTheme.headlineSmall,
        )),
        IconButton(
            onPressed: () {
              throw UnimplementedError();
            },
            icon: Icon(Icons.add))
      ],
    );
  }

  Widget _buildDecksListView(
    BuildContext context,
    DeckCollection collection,
    List<Deck> decks,
  ) {
    return Column(children: [
      IconButton(
          onPressed: () => throw UnimplementedError(), icon: Icon(Icons.close))
    ]);
  }

  Widget _buildDecksTreeView(
      BuildContext context, DeckCollection collection, List<Deck> decks) {
    if (decks.isEmpty) {
      return ElevatedButton(
          onPressed: () => throw UnimplementedError(), child: Text('Add Deck'));
    }

    return PathedTree(decks,
        getPath: (d) => collection.pathsToDeckIds![d.id]!,
        buildNode: (context, d) {
          return ListTile(title: Text(d?.name ?? ' - '));
        });
  }
}
