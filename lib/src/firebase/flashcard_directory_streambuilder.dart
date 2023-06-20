
import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/app.dart';
import 'package:flashcard_desktop_app/src/model/flashcard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:window_manager/window_manager.dart';

import '../viewmodels/flashcard_directory_viewmodel.dart';
import '../viewmodels/flashcard_viewmodel.dart';

Logger logger = Logger();

class FlashcardDirectoryStreambuilder extends StatefulWidget {

  final FlashcardDirectoriesSelectedChanged flashcardDirectoriesSelectedChanged = FlashcardDirectoriesSelectedChanged();

  FlashcardDirectoryStreambuilder(this.dirs);

final List<FlashcardDirectory>  dirs;

  @override
  State<StatefulWidget> createState() {
    return FlashcardDirectoryStreambuilderState();
  }

}


class FlashcardDirectoryStreambuilderState extends State<FlashcardDirectoryStreambuilder>{
  
  // final String flashcardCollection // In future, this will be a field that specifies collection

  final Logger logger = Logger();

  FlashcardDirectoryStreambuilderState(){
    //getStream().listen((event) { logger.d("${event.length} docs received"); });
  }


  FlashcardDirectoriesSelectedChanged get flashcardDirectoriesSelectedChanged => widget.flashcardDirectoriesSelectedChanged;

  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => directoryListing(context),
        '/study' : (context) => StudyScreen(flashcards),
      });
     
      }
      
        bool containsMe(FlashcardDirectory dir) {
          return flashcardDirectoriesSelectedChanged.directoryIds.contains(dir.path);
        }
      


  Widget directoryListing(BuildContext context) => Scaffold(
          appBar: AppBar(title: const Text("Flashcard App")),
          body: ListView(children: widget.dirs.map((dir) {
            return ListTile(
      title: Text(dir.path),
      leading: Checkbox(
        value: flashcardDirectoriesSelectedChanged.directoryIds.contains(dir.id),
        onChanged: (value) {
          setState(() {
              final id = dir.id;

              if(!flashcardDirectoriesSelectedChanged.directoryIds.contains(id)) {
                flashcardDirectoriesSelectedChanged.directoryIds.add(id);}
              else {
                flashcardDirectoriesSelectedChanged.directoryIds.remove(id);}
      
            logger.d(flashcardDirectoriesSelectedChanged.directoryIds.length);
            flashcardDirectoriesSelectedChanged.dispatch(context);
          });
        }),
    );
          }).toList()),
          floatingActionButton: flashcardDirectoriesSelectedChanged.directoryIds.isEmpty ? null 
            : FloatingActionButton(
             
              onPressed: studySessionLoading ? null :  () {
                setState(() {
                  studySessionLoading = true;
                });
                loadFlashcards().then((value) => Navigator.pushNamed(context, '/study'));
                
            }, child: const Text("Begin Study")),
         );
         
         bool studySessionLoading = false;

          List<Flashcard> flashcards = [];

          Future<bool> loadFlashcards() async {
            flashcards.clear();
            List<Future> futures = [];
            for(var id in flashcardDirectoriesSelectedChanged.directoryIds)
            {
              futures.add(Firestore.instance.collection('flashcards').where('directoryId', isEqualTo: id).get()
              .then((value) => flashcards.addAll(value.map((e) => Flashcard(e.id, e['prompt'], e['response'])))));
            }
            await Future.wait(futures);
            logger.d(flashcards.length);

            return true;
          }

}

class StudyScreen extends StatefulWidget {

  StudyScreen(this.flashcards, {super.key});
  final List<Flashcard> flashcards;

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {

  int timeInterval = 10;
  int secondsRemaining = 10;

  List<Flashcard> get flashcards => widget.flashcards;

  @override
  void initState() {
    super.initState();

    ServicesBinding.instance.keyboard.addHandler(onKey);
    initTimer();  
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
    t?.cancel();
    
    await Navigator.push(context, MaterialPageRoute(builder: (context){
        final r = Random();
        return FlashcardViewModel(flashcards[r.nextInt(flashcards.length)]);
    }));
    
    windowManager.setAlwaysOnTop(false);
    windowManager.setSize(Size(500,500));
    windowManager.setAlignment(Alignment.center);
    windowManager.setMinimizable(true);
    windowManager.blur();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(children: 
      [
        Text(secondsRemaining.toString()),

        Row(children: 
        [
            IconButton(onPressed: (){
              decrementSeconds();
              resetTimer();
            }, icon: const Icon(Icons.add))
        ],)

      ],)),
    );
  }
}



