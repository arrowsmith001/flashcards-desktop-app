import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/extensions/riverpod_extensions.dart';
import 'package:flashcard_desktop_app/src/model/classes/study_session.dart';
import 'package:flashcard_desktop_app/src/navigation/top_level_routes.dart';
import 'package:flashcard_desktop_app/src/notifiers/flashcard_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/flashcard_result_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/selected_decks_list_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/study_session_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/theme_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_service_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../main.dart';
import '../model/entities/flashcard_result.dart';
import '../window/app_window_manager.dart';

Logger logger = Logger();

class StudyView extends ConsumerStatefulWidget {
  const StudyView({super.key});

  @override
  ConsumerState<StudyView> createState() => _StudyViewState();
}

class _StudyViewState extends ConsumerState<StudyView> {
  
  // TODO: Make functions highly generalized, possible create a hook/mixin
  AsyncValue<StudySession> get getStudySessionAsync {
    final selectedDeckIds = ref.watch(selectedDecksListNotifierProvider);
    return ref.watch(studySessionNotifierProvider(selectedDeckIds));
  }

  Future<StudySession> get getStudySessionFuture {
    final selectedDeckIds = ref.watch(selectedDecksListNotifierProvider);
    return ref.watch(studySessionNotifierProvider(selectedDeckIds).future);
  }

  StudySessionNotifier get getStudySessionNotifier {
    final selectedDeckIds = ref.watch(selectedDecksListNotifierProvider);
    return ref.watch(studySessionNotifierProvider(selectedDeckIds).notifier);
  }

  bool isTransitioning = false;

  final int timeInterval = 45;
  int secondsRemaining = 45;

  @override
  void initState() {
    super.initState();
    //ServicesBinding.instance.keyboard.addHandler(onKey);
    initTimer();
  }

  late Timer t;

  void initTimer() {
    secondsRemaining = timeInterval;
    t = createTimer();
  }

  Timer createTimer() =>
      Timer.periodic(const Duration(seconds: 1), onTimerTick);

  void onTimerTick(Timer t) async {
    if (secondsRemaining > 0) {
      setState(() {
        secondsRemaining--;
      });
    }
    if (secondsRemaining == 0) onZero();
  }

  void advanceTimeToZero() async {
    setState(() {
      t.cancel();
      secondsRemaining = 0;
    });

    await Future.delayed(const Duration(milliseconds: 250));
    onZero();
  }

  void toggleTimer() {
    setState(() {
      if (!t.isActive) {
        t = createTimer();
      } else
        t.cancel();
    });
  }

  void onZero() async {
    final wm = ref.read(windowManagerProvider);
    AppLogger.log('onZero');
    t.cancel();

    setState(() {
      isTransitioning = true;
    });

    secondsRemaining = timeInterval;

    final String nextFlashcardId =
        getStudySessionNotifier.getRandomUnseenFlashcardId; // Handle exception

    final result = await Navigator.pushNamed<bool>(
        context, TopLevelRoutes.flashcardRoute,
        arguments: {'flashcardId': nextFlashcardId});

    ref.read(themeNotifierProvider.notifier).setMainAppTheme();
    
    await wm.setDefaultSizeAndPosition();
    await wm.blur();

    await wm.makeVisible();

    if (result != null) {
      final flashcardResult =
          FlashcardResult(null, nextFlashcardId, result, DateTime.now());
      getStudySessionNotifier.logResult(flashcardResult);
    }

    initTimer();

    setState(() {
      isTransitioning = false;
    });
  }

  bool onKey(KeyEvent event) {
    final key = event.logicalKey.keyLabel;

    logger.d("key: $key, event: ${event.runtimeType.toString()}");
    Navigator.pop(context);

    return true; // ?
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(onKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studySession = getStudySessionAsync;

    return Scaffold(
      body: isTransitioning
          ? Center(child: CircularProgressIndicator())
          : studySession.whenDefault((studySession) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildUpperSegment(context),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(children: [
                              Text("Summary"),
                              Expanded(child: _buildStudySummary(context))
                            ]),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Text("Results"),
                                Expanded(child: _buildDataTableView()),
                              ],
                            ),
                          )
                        ],
                      ))
                    ]),
              );
            }),
    );
  }

  ScrollController _scrollController = ScrollController();
  Widget _buildDataTableView() {
    final studySession = getStudySessionAsync;

    return studySession.whenDefault((session) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0)),
          child: Center(
              child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  child: session.flashcardResultIds.isEmpty
                      ? Center(child: Text("No data"))
                      : _buildDataTable())),
        ),
      );
    });
  }

  String getTimeString(int secondsRemaining) {
    if (secondsRemaining == 0) return '...';
    final int hours = (secondsRemaining / (60 * 60)).floor();
    final int minutes = (secondsRemaining / 60).floor() % 60;
    final int seconds = secondsRemaining % 60;
    final String hoursPart = hours <= 0 ? '' : '${hours.toString()}h ';
    final String minutesPart = minutes <= 0 ? '' : '${minutes.toString()}m ';
    return '$hoursPart$minutesPart${seconds.toString()}s';
  }

  Widget _buildDataTable() {
    final studySession = getStudySessionAsync.requireValue;

    return DataTable(
        clipBehavior: Clip.antiAlias,
        dataRowMaxHeight: 75,
        columns: [
          DataColumn(label: Text('Prompt')),
          DataColumn(label: Text('Response')),
          DataColumn(label: Text('Result')),
          DataColumn(label: Text('Time')),
        ],
        rows: studySession.flashcardResultIds.map<DataRow>((resultId) {
          final flashcardResultAsync =
              ref.watch(flashcardResultNotifierProvider(resultId));

          return flashcardResultAsync.when(
              data: (result) {
                final flashcardAsync =
                    ref.watch(flashcardNotifierProvider(result.flashcardId));

                return flashcardAsync.whenDefault((flashcard) {
                  return DataRow(cells: [
                    DataCell(Text(flashcard.prompt, softWrap: true)),
                    DataCell(Text(flashcard.response, softWrap: true)),
                    DataCell(result.correct
                        ? Icon(Icons.thumb_up, color: Colors.green)
                        : Icon(Icons.thumb_down, color: Colors.red)),
                    DataCell(Text(result.timestamp.toString(), softWrap: true)),
                  ]);
                });
              },
              loading: () => DataRow(
                  cells: List.generate(
                      4, (_) => DataCell(CircularProgressIndicator()))),
              error: (e, _) => DataRow(
                  cells:
                      List.generate(4, (_) => DataCell(Text(e.toString())))));
        }).toList());
  }

  Widget _buildUpperSegment(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                IconButton(
                    onPressed: () => exitStudy(context),
                    icon: Icon(Icons.close)),
                Expanded(
                    child: Slider(
                        activeColor: t.isActive ? null : Colors.grey,
                        thumbColor: t.isActive ? null : Colors.grey,
                        divisions: timeInterval,
                        value: secondsRemaining / timeInterval,
                        onChanged: (value) {
                          setState(() {
                            secondsRemaining = (value * timeInterval).floor();
                          });
                        })),
                Text("Next card in: "),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(children: [
                        Text(getTimeString(secondsRemaining),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                      ]),
                    ),
                  ),
                )
              ]),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(
                child: Row(
                    children: [Text("Fast Forward"), Icon(Icons.fast_forward)]),
                onPressed: () {
                  advanceTimeToZero();
                },
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(
                child: Row(children: [
                  Text(t.isActive ? "Pause" : "Resume"),
                  Icon(t.isActive ? Icons.pause : Icons.play_arrow)
                ]),
                onPressed: () {
                  toggleTimer();
                },
              )
            ]),
          ]),
        ),
      ],
    );
  }

  void exitStudy(BuildContext context) {
    t.cancel();
    Navigator.of(context).pop();
  }

  Widget _buildStudySummary(BuildContext context) {
    final studySession = getStudySessionAsync;

    final double fontSize = 28; // TODO: Extract to style

    return studySession.whenDefault((session) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8.0)),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${session.flashcardResultIds.length} cards done',
                style: TextStyle(color: Colors.black, fontSize: fontSize),
              ),
              Text('${session.numberCorrect} correct',
                  style: TextStyle(color: Colors.green, fontSize: fontSize)),
              Text('${session.numberIncorrect} incorrect',
                  style: TextStyle(color: Colors.red, fontSize: fontSize)),
            ],
          )),
        ),
      );
    });
  }
}
