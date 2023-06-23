
import 'dart:async';
import 'dart:math';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/model/flashcard.dart';
import 'package:flutter/material.dart' as material;
import 'package:logger/logger.dart';

import '../window/app_window_manager.dart';

Logger logger = Logger();

class StudyView extends StatefulWidget {

  const StudyView(this.flashcardDirectoryIds, {super.key});
  final List<String> flashcardDirectoryIds;

  @override
  State<StudyView> createState() => _StudyViewState();
}

class _StudyViewState extends State<StudyView> {

  int timeInterval = 10;
  int secondsRemaining = 10;

  List<Flashcard> flashcardsToDo = [];
  List<Flashcard> flashcardsDone = [];

  @override
  void initState() {
    super.initState();

    ServicesBinding.instance.keyboard.addHandler(onKey);
  }

  Timer? t;

  void initTimer(){
    secondsRemaining = timeInterval;
    resetTimer(); 
  }

  void resetTimer(){
    t?.cancel();
    t = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  void onTick(Timer t){
    decrementSeconds();
  }

  void decrementSeconds(){
    setState(() {
      if(secondsRemaining == 0)
      {
        onZero();
      }
      secondsRemaining--;
    });
  }

  void onZero() async {
    AppLogger.log('onZero');
    t?.cancel();
    secondsRemaining = timeInterval;
    
    final r = Random();
    final flashcard = flashcardsToDo[r.nextInt(flashcardsToDo.length)];

    await Navigator.pushNamed(context, NavigationManager.flashcardRoute, arguments: {'flashcard' : flashcard.serialized()});

    await AppWindowManager.setDefaultSizeAndPosition();
    await AppWindowManager.makeVisible();
    // TODO: Make a transition screen on the way out as well

    // TODO: Get result from flashcard

    flashcardsToDo.remove(flashcard);
    flashcardsDone.add(flashcard);
    
    initTimer();
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


    Future<bool> loadFlashcards() async {
      flashcardsToDo.clear();

      List<Future> futures = [];
      for(var id in widget.flashcardDirectoryIds)
      {
        futures.add(Firestore.instance.collection('flashcards').where('directoryId', isEqualTo: id).get()
        .then((value) => flashcardsToDo.addAll(value.map((e) => Flashcard(e.id, e['prompt'], e['response'])))));
      }
      await Future.wait(futures);
      logger.d("${flashcardsToDo.length} flashcards loaded");

      return true;
    }

  bool isInitialized = false;
  Future<bool> initializeStudySession() async {
    if(isInitialized) return false;
    AppLogger.log('initializeStudySession');
    await loadFlashcards();
    initTimer();
    isInitialized = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: initializeStudySession(),
        builder: ((context, snapshot) {
    
          if(!snapshot.hasData){ return const Center(child: material.CircularProgressIndicator()); }
          if(snapshot.hasError){ return Center(child: Text("There was an error: ${snapshot.error.toString()}"));}
    
          return Center(child: Column(
            mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center,
            children: 
                    [
                      Expanded(
                        child: Center(
                          child: Text(secondsRemaining.toString(), 
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                        ),
                      ),
    
                      Row(children: 
                      [
                          material.IconButton(onPressed: (){
                            decrementSeconds();
                            resetTimer();
                          }, icon: const Icon(material.Icons.add))
                      ],)
    
                    ],));
    
        })),
    );

  }

  

}



