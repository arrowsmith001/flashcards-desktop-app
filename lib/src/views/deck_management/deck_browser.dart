import 'dart:math';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/extensions/riverpod_extensions.dart';
import 'package:flashcard_desktop_app/src/custom/widgets/pathed_tree.dart';
import 'package:flashcard_desktop_app/src/model/classes/deck_collection_navigation_helper.dart';
import 'package:flashcard_desktop_app/src/navigation/deck_browser_list_view_routes.dart';
import 'package:flashcard_desktop_app/src/notifiers/current_path_notifier.dart';
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

// "Add deck" wizard (enforce deck creation at path somehow)

void onAddDeck(WidgetRef ref) async {
  final id = ref.read(getCurrentDeckCollectionIdProvider);

  final r = Random();

  final notifier = ref.read(deckCollectionListNotifierProvider.notifier);
  final path = ref.read(getCurrentPathProvider);

  //await notifier.addDeckToCollection(newDeck, id, path);
}

void onAddSubfolder(WidgetRef ref, String folderName) async {}

class DeckBrowser extends ConsumerWidget {
  DeckBrowser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(getCurrentDeckCollectionIdProvider);
    final collection = ref.watch(deckCollectionNotifierProvider(id));

    return collection.whenDefault((collection) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                _buildDeckBrowserHeader(context, collection, ref),
                Flexible(
                  child: _buildBrowserBody(),
                ),
              ],
            )),
          ],
        ),
      );
    });
  }

  Widget _buildDeckBrowserHeader(
      BuildContext context, DeckCollection collection, WidgetRef ref) {
    return Row(
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
            )
          ],
        )),
        IconButton(
            onPressed: () {
              AppLogger.log(ref.read(currentPathNotifierProvider));
            },
            /*                       onPressed: () {
                        onAddDeck(ref);
                      }, */
            icon: Icon(Icons.add))
      ],
    );
  }

  Widget _buildBrowserBody() {
    return const Navigator(
      initialRoute: '',
      onGenerateRoute: DeckBrowserListViewRoutes.generateRoute,
    );
  }
}
