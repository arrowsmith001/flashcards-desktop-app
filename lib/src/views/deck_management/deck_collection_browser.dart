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

  List<String> selectedDirectoryIds = [];

  void onDeleteCollection(DeckCollection dc) async {
    await ref.read(deleteDeckCollectionProvider(dc));
  }

  Future<void> onAddDeckCollection(BuildContext context) async {
    var dc = await navigationKey.currentState!.pushNamed('/new');
    if (dc != null) {
      await ref.read(addDeckCollectionProvider(dc as DeckCollection));
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
            return DeckBrowser(id);
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
    final deckCollections = ref.watch(deckCollectionsProvider);

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        deckCollections.when(
            data: (data) {
              return data.isEmpty
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
                      children: data
                          .map((e) => ListTile(
                                onTap: () => navigationKey.currentState!
                                    .pushNamed('/collection/${e.id}'),
                                title: Text(e.name!), //Text(e.name!),
                                trailing: IconButton(
                                    onPressed: () => onDeleteCollection(e),
                                    icon: Icon(Icons.delete)),
                              ))
                          .toList());
            },
            loading: () => CircularProgressIndicator(),
            error: (e, _) => Text(e.toString()))
      ],
    );
  }
}
