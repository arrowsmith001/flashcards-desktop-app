import 'package:auto_size_text/auto_size_text.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/model/flashcard.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';

class FlashcardView extends StatefulWidget {
  FlashcardView(this.flashcard, {super.key});

  final Flashcard flashcard;
  final _navKey = GlobalKey<NavigatorState>();

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView>
    with TickerProviderStateMixin {
  WindowManagerWrapper get windowManager => GetIt.I.get<WindowManagerWrapper>(); 

  Flashcard get flashcard  => widget.flashcard;

  late AnimationController _entryAnimationController;
  late CurvedAnimation entryAnim;

  late AnimationController _transitionAnimationController;
  late CurvedAnimation transitionAnim;

  dismissFlashcard() async
  {


    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      
        windowManager.dismissAndMakeInvisible().then((value) => Navigator.of(context, rootNavigator: true).pop());

     });
  }

  
  onTapResponse(bool bool) {

    setState(() {
      transitioningBack = true;
    });

    windowManager.dismissAndMakeInvisible().then((value) => Navigator.of(context).pop(bool));
  }

  @override
  void initState() {
    super.initState();

    _entryAnimationController = AnimationController(
      vsync: this, 
      value: 1, 
      duration: const Duration(milliseconds: 500));
    _entryAnimationController.addListener(() {setState(() {});});

    _transitionAnimationController = AnimationController(
      vsync: this, 
      value: 0, 
      duration: const Duration(milliseconds: 500));
    _transitionAnimationController.addListener(() {setState(() {});});

    entryAnim = CurvedAnimation(parent: _entryAnimationController, curve: Curves.easeOut);
    transitionAnim = CurvedAnimation(parent: _transitionAnimationController, curve: Curves.easeInOut);
    
    windowManager.setNotificationModeSizeAndPosition().then((v) => _entryAnimationController.animateTo(0));
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
      switch(flashcardState)
      {
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
    return transitioningBack ? const Center(child: CircularProgressIndicator())
    : Transform.translate(
        offset: Offset(WindowManagerWrapper.notificationModeSize.width * entryAnim.value, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Scaffold(
              body: transitioningBack ? const Center(child: CircularProgressIndicator()) 
              : buildFlashcard(context)),
          ),
        ));
  }
  
  double get windowWidth => WindowManagerWrapper.notificationModeSize.width; 

  Widget buildFlashcard(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        children: 
      [
        Expanded(child: 
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(children: [
              Transform.translate(offset: Offset(0, -windowWidth * transitionAnim.value),
                child: buildPrompt(context)),
              Transform.translate(offset: Offset(0, windowWidth * (1 - transitionAnim.value)),
                child: buildResponse(context)),
            ],),
          )),
    
          Stack(children: [
            Opacity(
              opacity: clampDouble((1 - transitionAnim.value), 0, 1),
              child: Column(children: [
                Expanded(
                  child: Container(
                  width: 50,
                  decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle),
                              child: const Icon(Icons.ads_click_sharp, color: Colors.black),
                            ),
                )
              ]),
            ),
    
            Opacity(
              opacity: clampDouble(transitionAnim.value, 0, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                Expanded(
                  child: IconButton(
                    onPressed: () => onTapResponse(true),
                    icon: Icon(Icons.thumb_up, color: Colors.green),
/*                     child: Container(decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle),
                                child: const Icon(Icons.thumb_up, color: Colors.green),
                              ), */
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () => onTapResponse(false),
                    icon: Icon(Icons.thumb_down, color: Colors.red),
/*                     child: Container(decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle),
                                child: const Icon(Icons.thumb_up, color: Colors.green),
                              ), */
                  ),
                )
              ]),
            )
          ])
      ]),
    );
  }

  Widget buildPrompt(BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: AutoSizeText(flashcard.prompt, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          ],
        );
  }  

  Widget buildResponse(BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: AutoSizeText(flashcard.response, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          ],
        );
  }
  
  
  
  
}