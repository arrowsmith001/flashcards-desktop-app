import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/widgets/pathed_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../../main.dart';
import '../../model/entities/deck.dart';
import '../../model/entities/deck_collection.dart';
import '../../providers/deck_collection_providers.dart';
import '../../providers/deck_providers.dart';

final currentDeckCollectionProvider = Provider<DeckCollection>((ref) {
  throw UnimplementedError('currentDeckCollectionProvider');
});

final currentDecksProvider = Provider<List<Deck>>((ref) {
  throw UnimplementedError('currentDecksProvider');
});

final deckCollectionProvider =
    FutureProvider.family<DeckCollection, String>((ref, id) async {
  await Future.delayed(Duration(seconds: 1));
  return DeckCollection('0', null, 'name 0', {}, true);
});
final decksProvider =
    FutureProvider.family<List<Deck>, Iterable<String>>((ref, id) async {
  await Future.delayed(Duration(seconds: 1));
  return [];
});

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
    final collectionAsync = ref.watch(deckCollectionProvider('collectionId'));
    final decksAsync = ref.watch(decksProvider([]));

    return Column(
      children: [
        Expanded(
          child: collectionAsync.when(
              data: (collection) {
                return ProviderScope(
                  overrides: [
                    currentDeckCollectionProvider.overrideWithValue(collection),
                    currentDecksProvider
                        .overrideWithValue(decksAsync.value ?? []),
                  ],
                  child: TestWidget(),
                );
              },
              error: (e, _) => Text(e.toString()),
              loading: () => CircularProgressIndicator(color: Colors.blue)),
        ),
      ],
    );
  }

/*   @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final collectionAsync = ref.watch(deckCollectionProvider(collectionId));
      final decksAsync = ref.watch(
          decksProvider(collectionAsync.value?.pathsToDeckIds?.values ?? []));

      return Column(
        children: [
          Expanded(
            child: collectionAsync.when(
                data: (collection) {
                  return ProviderScope(
                    overrides: [
                      currentDeckCollectionProvider
                          .overrideWithValue(collection),
                      currentDecksProvider
                          .overrideWithValue(decksAsync.value ?? []),
                    ],
                    child: Column(
                      children: [
                        _buildDeckBrowserTopRow(context),
                        Flexible(
                          child: _buildDecksView(context),
                        ),
                      ],
                    ),
                  );
                },
                error: (e, _) => Text(e.toString()),
                loading: () => CircularProgressIndicator(color: Colors.blue)),
          ),
        ],
      );
    });
  } */

  Widget _buildDecksView(BuildContext context) {
    final collection = ref.watch(currentDeckCollectionProvider);
    final decksAsync =
        ref.watch(decksProvider(collection.pathsToDeckIds?.values ?? []));

    return decksAsync.when(
        data: (decks) {
          return ProviderScope(
              overrides: [
                // decksProvider.overrideWith((ref, it) => decks)
              ],
              child: treeViewMode
                  ? _buildDecksTreeView(context)
                  : _buildDecksListView(context));
        },
        error: (e, _) => Text(e.toString()),
        loading: () => CircularProgressIndicator());
  }

  Widget _buildDeckBrowserTopRow(BuildContext context) {
    final collection = ref.watch(currentDeckCollectionProvider);

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
  ) {
    return Column(children: [
      IconButton(
          onPressed: () => throw UnimplementedError(), icon: Icon(Icons.close))
    ]);
  }

  Widget _buildDecksTreeView(BuildContext context) {
    final collection = ref.watch(currentDeckCollectionProvider);
    final decks = ref.watch(currentDecksProvider);

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

class TestWidget extends ConsumerStatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends ConsumerState<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ref.watch(currentDeckCollectionProvider).name!);
  }
}
