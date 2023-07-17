import 'package:flashcard_desktop_app/src/custom/extensions/riverpod_extensions.dart';
import 'package:flashcard_desktop_app/src/notifiers/deck_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/selected_decks_list_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyPrepWindow extends ConsumerStatefulWidget {
  const StudyPrepWindow({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StudyPrepWindowState();
}

class _StudyPrepWindowState extends ConsumerState<StudyPrepWindow> {
  @override
  Widget build(BuildContext context) {
    final selectedDeckIds = ref.watch(selectedDecksListNotifierProvider)
    //.expand((element) => List<String>.filled(20, element)).toList()
    ;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Study Session',
        style: Theme.of(context).textTheme.headlineSmall,
        overflow: TextOverflow.clip,
        maxLines: 1,
      ),
      Expanded(
        child: Container(
          color: Colors.teal[50],
          child: ListView(
              children: selectedDeckIds.map<Widget>((deckId) {
                return ProviderScope(overrides: [
                  getCurrentDeckIdProvider.overrideWithValue(deckId)
                ], child: StudyPrepDeckEntryListItem());
              }).toList()),
        ),
      )
    ]);
  }
}

class StudyPrepDeckEntryListItem extends ConsumerStatefulWidget {
  const StudyPrepDeckEntryListItem({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StudyPrepDeckEntryListItemState();
}

class _StudyPrepDeckEntryListItemState
    extends ConsumerState<StudyPrepDeckEntryListItem> {
  @override
  Widget build(BuildContext context) {
    final deckId = ref.watch(getCurrentDeckIdProvider);
    final deckAsync = ref.watch(deckNotifierProvider(deckId));

    return deckAsync.whenDefault(data: (deck) {
      return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: Text(
                deck.name!,
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
            ),
            Spacer(),
            Flexible(
              child: Text(
                '${deck.numberOfCards} cards',
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.clip,
                maxLines: 2,
              ),
            ),
            Flexible(
              child: IconButton(
                  onPressed: () {
                    final notifier =
                        ref.read(selectedDecksListNotifierProvider.notifier);
                    notifier.toggleSelected(deckId);
                  },
                  icon: Icon(Icons.close)),
            )
          ]),
        ),
      );
    });
  }
}
