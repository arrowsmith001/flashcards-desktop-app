import 'dart:collection';
import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/widgets/card_window.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/navigation/route_generator.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';
import 'package:flashcard_desktop_app/src/services/app_database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../../main.dart';
import '../../custom/data/abstract/database_service.dart';
import '../../model/entities/deck.dart';
import '../../model/entities/flashcard.dart';
import '../../model/entities/user.dart';
import '../../providers/deck_collection_providers.dart';
import '../../services/app_deck_service.dart';
import '../../window/app_window_manager.dart';
import 'deck_browser.dart';
import 'deck_collection_browser.dart';

class DeckManagementView extends ConsumerStatefulWidget {
  const DeckManagementView({super.key});

  @override
  ConsumerState<DeckManagementView> createState() => _DeckManagementViewState();
}

class _DeckManagementViewState extends ConsumerState<DeckManagementView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deckBrowser = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: _buildDeckCollectionBrowser(context),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [
              Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 5,
                child: Row(children: [
                  Flexible(flex: 1 * 0, child: Container()),
                  Flexible(flex: 6, child: deckBrowser),
                  Flexible(
                    flex: 6 * 0,
                    child: Column(
                      children: [
                        Expanded(child: CardWindow(child: Container())),
                        Expanded(child: CardWindow(child: Container())),
                      ],
                    ),
                  ),
                  Flexible(flex: 1 * 0, child: Container()),
                ]),
              ),
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GlobalKey<NavigatorState> deckBrowserNavigationKey = GlobalKey();

  Widget _buildDeckCollectionBrowser(BuildContext context) {
    return CardWindow(child: DeckCollectionBrowser());
    /*  deckCollectionListAsync.when(
            data: (deckCollectionList) => DeckBrowser(),
            error: (e, _) => Center(child: Text(e.toString())),
            loading: () => Center(child: CircularProgressIndicator()))); */
  }
}



/*   void onBeginStudy(context) {
    final AppWindowManager wm = ref.watch(windowManagerProvider);
    Navigator.pushNamed(context, RouteGenerator.studyRoute, arguments: {
      'flashcardDirectoryIds': selectedDirectoryIds,
      'windowSize': wm.currentSize
    });
    */
