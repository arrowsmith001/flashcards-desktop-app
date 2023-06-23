import 'package:flashcard_desktop_app/src/model/flashcard.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/material.dart';

class FlashcardView extends StatefulWidget {
  const FlashcardView(this.flashcard, {super.key});

  final Flashcard flashcard;

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView>
    with SingleTickerProviderStateMixin {

  Flashcard get flashcard  => widget.flashcard;

  late AnimationController _controller;
  late CurvedAnimation curvedAnim;

  dismissFlashcard() async
  {
    setState(() {
      transitioningBack = true;
    });
    await AppWindowManager.dismissAndMakeInvisible().then((value) => Navigator.of(context).pop());
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this, 
      value: 1, 
      duration: const Duration(milliseconds: 500));
    _controller.addListener(() {setState(() {
    });});

    curvedAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    
    AppWindowManager.setNotificationModeSizeAndPosition().then((v) => _controller.animateTo(0));
  }

  @override
  void dispose() {
    _controller.dispose();
    curvedAnim.dispose();
    super.dispose();
  }     

  bool transitioningBack = false;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(AppWindowManager.notificationModeSize.width * curvedAnim.value, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Scaffold(
              body: transitioningBack ? const Center(child: CircularProgressIndicator()) 
              : InkWell(
                hoverColor: Colors.grey.shade300,
                onTap: () => dismissFlashcard(),
                child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(children: 
                  [
                    Expanded(child: Text(flashcard.prompt, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                    Container(decoration: const BoxDecoration(
                              shape: BoxShape.rectangle),
                          child: const Icon(Icons.arrow_forward, color: Colors.black),
                        )
                  ])
              ),
                  
              ),
                )),
          ),
        ));
  }
  
}