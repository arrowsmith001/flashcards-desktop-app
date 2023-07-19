import 'package:auto_size_text/auto_size_text.dart';
import 'package:flashcard_desktop_app/main.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/extensions/riverpod_extensions.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/notifiers/flashcard_notifier.dart';
import 'package:flashcard_desktop_app/src/notifiers/theme_notifier.dart';
import 'package:flashcard_desktop_app/src/providers/app_service_providers.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Theme override!
class FlashcardView extends ConsumerStatefulWidget {
  FlashcardView({super.key});

  final _navKey = GlobalKey<NavigatorState>();

  @override
  ConsumerState<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends ConsumerState<FlashcardView>
    with TickerProviderStateMixin {
  late AnimationController _entryAnimationController;
  late CurvedAnimation entryAnim;

  late AnimationController _transitionAnimationController;
  late CurvedAnimation transitionAnim;

  AsyncValue<Flashcard> get getFlashcardAsync {
    final currentFlashcardId = ref.watch(getCurrentFlashcardIdProvider);
    return ref.watch(flashcardNotifierProvider(currentFlashcardId));
  }

  Future<void> dismissFlashcard() async {
    final wm = ref.read(windowManagerProvider);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      wm
          .dismissAndMakeInvisible()
          .then((value) => Navigator.of(context, rootNavigator: true).pop());
    });
  }

  void onTapResponse(bool bool) {
    final wm = ref.read(windowManagerProvider);

    setState(() {
      transitioningBack = true;
    });

    wm
        .dismissAndMakeInvisible()
        .then((value) => Navigator.of(context).pop(bool));
  }

  @override
  void initState() {
    super.initState();

    final wm = ref.read(windowManagerProvider);

    _entryAnimationController = AnimationController(
        vsync: this, value: 1, duration: const Duration(milliseconds: 500));
    _entryAnimationController.addListener(() {
      setState(() {});
    });

    _transitionAnimationController = AnimationController(
        vsync: this, value: 0, duration: const Duration(milliseconds: 500));
    _transitionAnimationController.addListener(() {
      setState(() {});
    });

    entryAnim = CurvedAnimation(
        parent: _entryAnimationController, curve: Curves.easeOut);
    transitionAnim = CurvedAnimation(
        parent: _transitionAnimationController, curve: Curves.easeInOut);

    wm
        .setNotificationModeSizeAndPosition()
        .then(
            (_) => ref.read(themeNotifierProvider.notifier).setFlashcardTheme())
        .then((_) => _entryAnimationController.animateTo(0));
  }

  @override
  void dispose() {
    _entryAnimationController.dispose();
    entryAnim.dispose();
    super.dispose();
  }

  bool transitioningBack = false;
  int flashcardState = 0;

  void onTap() {
    setState(() {
      switch (flashcardState) {
        case 0:
          _transitionAnimationController.animateTo(1);
          flashcardState = 1;
        case 1:
          _transitionAnimationController.animateTo(0);
          flashcardState = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcardAsync = getFlashcardAsync;

    return transitioningBack
        ? const Center(child: CircularProgressIndicator())
        : Transform.translate(
            offset: Offset(
                AppWindowManager.notificationModeSize.width * entryAnim.value,
                0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Scaffold(
                    body: flashcardAsync
                        .whenDefault((data) => buildFlashcard(context))),
              ),
            ));
  }

  double get windowWidth => AppWindowManager.notificationModeSize.width;

  bool get isPromptShowing => transitionAnim.value < 0.5;
  bool get isResponseShowing => transitionAnim.value > 0.5;

  Widget buildFlashcard(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap(),
        child: Row(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Transform.translate(
                    offset: Offset(0, -windowWidth * transitionAnim.value),
                    child: buildPrompt(context)),
                Transform.translate(
                    offset: Offset(0, windowWidth * (1 - transitionAnim.value)),
                    child: buildResponse(context)),
              ],
            ),
          )),
          Stack(children: [
            IgnorePointer(
              ignoring: !isPromptShowing,
              child: Opacity(
                opacity: clampDouble((1 - transitionAnim.value), 0, 1),
                child: Column(
                  children: [
                  Expanded(
                    child: Container(
                      width: 50,
                      decoration: const BoxDecoration(shape: BoxShape.rectangle),
                      child:
                          IconButton(
                            icon: Icon(Icons.ads_click_sharp, color: Colors.black), 
                            onPressed: () => onTap(),),
                    ),
                  )
                ]),
              ),
            ),
            IgnorePointer(
              ignoring: !isResponseShowing,
              child: Opacity(
                opacity: clampDouble(transitionAnim.value, 0, 1),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(
                          width: 50,
                          child: IconButton(
                            onPressed: isPromptShowing ? null : () => onTapResponse(true),
                            icon: Icon(Icons.thumb_up, color: Colors.green),
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: isPromptShowing ? null : () => onTapResponse(false),
                          icon: Icon(Icons.thumb_down, color: Colors.red),
                        ),
                      )
                    ]),
              ),
            )
          ])
        ]),
      ),
    );
  }

  Widget buildPrompt(BuildContext context) {
    final Flashcard flashcard = getFlashcardAsync.requireValue;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: AutoSizeText(flashcard.prompt,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget buildResponse(BuildContext context) {
    final Flashcard flashcard = getFlashcardAsync.requireValue;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: AutoSizeText(flashcard.response,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold))),
      ],
    );
  }
}
