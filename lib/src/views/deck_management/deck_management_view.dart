import 'dart:collection';
import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/widgets/card_window.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/navigation/route_generator.dart';
import 'package:flashcard_desktop_app/src/notifiers/selected_decks_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/deck_providers.dart';
import 'package:flashcard_desktop_app/src/services/app_database_services.dart';
import 'package:flashcard_desktop_app/src/views/deck_management/study_prep_window.dart';
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

class _DeckManagementViewState extends ConsumerState<DeckManagementView>
    with SingleTickerProviderStateMixin {
  late AnimationController _entryAnimController;
  late CurvedAnimation _entryAnim;

  @override
  void initState() {
    super.initState();
    _entryAnimController = AnimationController(
        duration: Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1.0,
        vsync: this);
    _entryAnim = CurvedAnimation(
        parent: _entryAnimController, curve: Curves.easeInOutCubic);

    _entryAnimController.addListener(() {
      setState(() {
        setFlex(_entryAnim.value);
      });
      //AppLogger.log('$currentDeckBrowserFlex : $currentStudyBrowserFlex');
    });

    ref.listenManual(selectedDecksListNotifierProvider, (prev, next) {
      if ((prev == null || prev.isEmpty) && next.isNotEmpty) {
        _entryAnimController.forward();
      }
      if ((prev != null && prev.isNotEmpty) && next.isEmpty) {
        _entryAnimController.reverse();
      }
    });
  }

  static const int FLEX_DECK_BROWSER = 6;
  static const int FLEX_STUDY_PREP = 2;

  double ratio = 0;

  int currentDeckBrowserFlex = 100;
  int currentStudyBrowserFlex = 0;

  @override
  Widget build(BuildContext context) {
    final deckBrowser = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: CardWindow(child: DeckCollectionBrowser()),
    );

    final studyPrepWindow = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: CardWindow(child: StudyPrepWindow()),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 50.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(flex: currentDeckBrowserFlex, child: deckBrowser),
                    currentStudyBrowserFlex > 0
                        ? Flexible(
                            flex: currentStudyBrowserFlex,
                            child: Opacity(
                              opacity: currentStudyBrowserFlex.toDouble() / 33,
                              child: Column(
                                children: [
                                  Spacer(flex: 1),
                                  Flexible(flex: 10, child: studyPrepWindow),
                                  Expanded(
                                      child: ElevatedButton(
                                    onPressed: () {
                                      onBeginStudy(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Begin Study',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: Colors.white),
                                        maxLines: 1,
                                      ),
                                    ),
                                  )),
                                  Spacer(flex: 1),
                                ],
                              ),
                            ))
                        : Flexible(child: SizedBox.shrink()),
                  ],
                ),
              ),

              // Testing stuff
              Slider(
                  value: ratio,
                  onChanged: (value) {
                    setState(() {
                      ratio = value;
                    });
                    setFlex(value);
                  })
            ],
          ),
        ),
      ),
    );
  }

  GlobalKey<NavigatorState> deckBrowserNavigationKey = GlobalKey();

  void setFlex(double value) {
    setState(() {
      currentStudyBrowserFlex = (33 * (value)).toInt();
      currentDeckBrowserFlex = 100 - currentStudyBrowserFlex;
    });
  }

  void onBeginStudy(context) {
    final AppWindowManager wm = ref.watch(windowManagerProvider);

    final selectedIds = ref.read(selectedDecksListNotifierProvider);

    Navigator.pushNamed(context, RouteGenerator.studyRoute, arguments: {
      'flashcardDirectoryIds': selectedIds,
      'windowSize': wm.currentSize
    });
  }
}
