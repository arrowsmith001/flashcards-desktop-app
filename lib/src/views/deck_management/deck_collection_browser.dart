import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_list_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_collection_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/entities/deck_collection.dart';
import '../../providers/deck_collection_providers.dart';
import 'deck_browser.dart';

class DeckCollectionBrowser extends ConsumerStatefulWidget {
  DeckCollectionBrowser({super.key});

  @override
  ConsumerState<DeckCollectionBrowser> createState() =>
      _DeckCollectionBrowserState();
}

class _DeckCollectionBrowserState extends ConsumerState<DeckCollectionBrowser> {
  GlobalKey<NavigatorState> navigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
/*     
    final notifier = ref.watch(deckCollectionListNotifierProvider.notifier);
    notifier.getDeckCollections(); */
  }

  List<String> selectedDirectoryIds = [];

  Future<void> onAddDeckCollection(BuildContext context) async {
    var dc =
        await navigationKey.currentState!.pushNamed('/new') as DeckCollection?;
    if (dc != null) {
      final notifier = ref.read(deckCollectionListNotifierProvider.notifier);
      await notifier.addDeckCollection(dc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigationKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        final name = settings.name;
        switch (name) {
          case '/':
            return MaterialPageRoute(builder: (_) {
              return _buildDeckCollectionHomePage(context);
            });
          case '/new':
            return MaterialPageRoute<DeckCollection?>(builder: (_) {
              return _buildAddDeckCollectionPage(context);
            });
/*           case '/collection':
            return MaterialPageRoute<DeckCollection?>(builder: (_) {
              return _buildBrowseDeckCollection(context);
            }); */
        }
        if (name != null && name.startsWith('/collection')) {
          final id = name.split('/').last;
          return MaterialPageRoute<DeckCollection?>(builder: (_) {
            return ProviderScope(overrides: [
              getCurrentDeckCollectionIdProvider.overrideWithValue(id),
              getCurrentPathProvider.overrideWithValue(''),
            ], child: DeckBrowser());
          });
        }

        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => Text('Unknown route'));
      },
    );
  }

  Widget _buildDeckCollectionHomePage(BuildContext context) {
    final divider = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Divider(height: 2),
    );

    final topRow = _buildDeckCollectionPageTopRow(context);
    final list = _buildDeckCollectionList(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [topRow, divider, Expanded(child: list)],
    );
  }

  TextEditingController addDeckCollectionNameField = TextEditingController();
  GlobalKey<FormState> addDeckCollectionFormKey = GlobalKey();

  Widget _buildAddDeckCollectionPage(BuildContext context) {
    return Center(
      child: Form(
        key: addDeckCollectionFormKey,
        child: Column(
          children: [
            IconButton(
                onPressed: () => navigationKey.currentState!.pop(null),
                icon: Icon(Icons.cancel)),
            Expanded(
                child: Row(
              children: [
                Spacer(),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Name:'),
                      TextFormField(
                          validator: (value) => value == null || value.isEmpty
                              ? 'Name must not be blank'
                              : null,
                          controller: addDeckCollectionNameField),
                    ],
                  ),
                ),
                Spacer(),
              ],
            )),
            IconButton(
                onPressed: () {
                  if (addDeckCollectionFormKey.currentState!.validate()) {
                    final newCollection = DeckCollection(
                        null, null, addDeckCollectionNameField.text, {}, true);

                    Navigator.of(navigationKey.currentContext!)
                        .pop(newCollection);
                  }
                },
                icon: Icon(Icons.create))
          ],
        ),
      ),
    );
  }

  TextEditingController deckCollectionNameController = TextEditingController();

  Widget _buildDeckCollectionPageTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Text(
          'Deck Collections',
          style: Theme.of(context).textTheme.headlineSmall,
        )),
        IconButton(
            onPressed: () {
              onAddDeckCollection(context);
            },
            icon: Icon(Icons.add))
      ],
    );
  }

/*        ,
      )); */

  Widget _buildDeckCollectionList(BuildContext context) {
    final deckCollectionsNotifier =
        ref.watch(deckCollectionListNotifierProvider);

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        deckCollectionsNotifier.when(
            data: (deckCollectionIds) {
              return deckCollectionIds.isEmpty
                  ? InkWell(
                      onTap: () => onAddDeckCollection(context),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Add a Deck Collection',
                              style: Theme.of(context).textTheme.bodyLarge),
                          Icon(Icons.add)
                        ],
                      )),
                    )
                  : ListView(
                      shrinkWrap: true,
                      children: deckCollectionIds.map((dcid) {
                        return ProviderScope(
                          overrides: [
                            getCurrentDeckCollectionIdProvider
                                .overrideWithValue(dcid)
                          ],
                          child: DeckCollectionListItem((id) => navigationKey
                              .currentState!
                              .pushNamed('/collection/$id')),
                        );
                      }).toList());
            },
            loading: () => CircularProgressIndicator(),
            error: (e, _) => Text(e.toString() + " : " + _.toString()))
      ],
    );
  }
}

class DeckCollectionListItem extends ConsumerWidget {
  void Function(String) onTap;

  DeckCollectionListItem(this.onTap, {super.key});

  Future<void> onDeleteCollection(WidgetRef ref, String collectionId) async {
    final notifier = ref.read(deckCollectionListNotifierProvider.notifier);
    await notifier.deleteDeckCollection(collectionId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(getCurrentDeckCollectionIdProvider);
    final notifier = ref.watch(deckCollectionNotifierProvider(id));

    return notifier.when(
        data: (dc) => ListTile(
              onTap: () => onTap(id),
              title: Text(dc.name!), //Text(e.name!),
              trailing: IconButton(
                  onPressed: () => onDeleteCollection(ref, dc.id!),
                  icon: Icon(Icons.delete)),
            ),
        error: (e, _) => Text(e.toString()),
        loading: () => CircularProgressIndicator());
  }
}
