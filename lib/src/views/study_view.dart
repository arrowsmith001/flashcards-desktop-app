
import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/navigation/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flutter/material.dart' as material;
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../model/entities/flashcard_result.dart';
import '../window/app_window_manager.dart';

Logger logger = Logger();

class StudyView extends StatefulWidget {

  const StudyView(this.flashcardDirectoryIds, {super.key});
  final List<String> flashcardDirectoryIds;

  @override
  State<StudyView> createState() => _StudyViewState();
}

class _StudyViewState extends State<StudyView> {

  WindowManagerWrapper get windowManager => GetIt.I.get<WindowManagerWrapper>(); 

  bool isTransitioning = false;

  final int timeInterval = 45;
  int secondsRemaining = 45;

  List<Flashcard> flashcardsToDo = [];
  List<FlashcardResult> flashcardsResults = [];

  @override
  void initState() {
    super.initState();

    ServicesBinding.instance.keyboard.addHandler(onKey);
  }
  

  late Timer t;

  void initTimer(){
    secondsRemaining = timeInterval;
    t = createTimer();
  }

  Timer createTimer() => Timer.periodic(const Duration(seconds: 1), onTick);

  void onTick(Timer t) async {
    if(secondsRemaining > 0) {
      setState(() {
        secondsRemaining --;
      });
    }
    if(secondsRemaining == 0) onZero();
  }

  void advanceTime() async { 
    setState(() {
      t.cancel();
      secondsRemaining = 0;
    });

      await Future.delayed(Duration(milliseconds: 250));
      onZero();
  }

  void toggleTimer(){
    setState(() {
      if(!t.isActive){
        t = createTimer();
      }
      else t.cancel();
    });
  }


  void onZero() async {
    AppLogger.log('onZero');
    t.cancel();

    setState(() {
      isTransitioning = true;
    });
    
    secondsRemaining = timeInterval;
    
    final r = Random();
    final flashcard = flashcardsToDo[r.nextInt(flashcardsToDo.length)];

    final result = await Navigator.pushNamed<bool>(context, RouteGenerator.flashcardRoute, arguments: {'flashcard' : flashcard.serialized()});

    await windowManager.setDefaultSizeAndPosition();
    await windowManager.blur();

    await windowManager.makeVisible();

    if(result != null)
    {
      flashcardsToDo.remove(flashcard);
      flashcardsResults.add(FlashcardResult(null, flashcard.id!, result, DateTime.now()));
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

    // TODO: Lazy load from database
    Future<bool> loadFlashcards() async {
      flashcardsToDo.clear();

      List<Future> futures = [];
      for(var id in widget.flashcardDirectoryIds)
      {
        // futures.add(Firestore.instance.collection('flashcards').where('directoryId', isEqualTo: id).get()
        // .then((value) => flashcardsToDo.addAll(value.map((e) => Flashcard(e.id, e['prompt'], e['response'])))));
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
      body: isTransitioning ? Center(child: CircularProgressIndicator()) 
      : FutureBuilder(
        future: initializeStudySession(),
        builder: ((context, snapshot) {
    
          if(!snapshot.hasData){ return const Center(child: material.CircularProgressIndicator()); }
          if(snapshot.hasError){ return Center(child: Text("There was an error: ${snapshot.error.toString()}"));}
    

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

              _buildUpperSegment(context),

              Expanded(
                child: Row(children: [

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

                ],)
              )
            ]),
          );
    
        })),
    );

  }
ScrollController _scrollController = ScrollController();
  Widget _buildDataTableView() {
    return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          child: flashcardsResults.isEmpty ? Center(child: Text("No data"))
                            : _buildDataTable())),
                    ),
                  );
  }
  
  String getTimeString(int secondsRemaining) {
    if(secondsRemaining == 0) return '...';
    final int hours = (secondsRemaining / (60*60)).floor();
    final int minutes = (secondsRemaining / 60).floor() % 60;
    final int seconds = secondsRemaining % 60;
    final String hoursPart = hours <= 0 ? '' : '${hours.toString()}h ';
    final String minutesPart = minutes <= 0 ? '' : '${minutes.toString()}m ';
    return '$hoursPart$minutesPart${seconds.toString()}s';
  }
  
  Widget _buildDataTable() {
    return DataTable(
                            clipBehavior: Clip.antiAlias,
                            dataRowMaxHeight: 75,
                            
                                          
                            columns: [
                            DataColumn(label: Text('Prompt')),
                            DataColumn(label: Text('Response')),
                            DataColumn(label: Text('Result')),
                            DataColumn(label: Text('Time')),
                          ], rows: 
                              flashcardsResults.map((r) {
                            return DataRow(cells: [
                                //DataCell(Text(r.flashcard.prompt, softWrap: true)),
                                //DataCell(Text(r.flashcard.response, softWrap: true)),
                                DataCell(r.correct ? Icon(Icons.thumb_up, color: Colors.green) : Icon(Icons.thumb_down, color: Colors.red)),
                                DataCell(Text(r.timestamp.toString(), softWrap: true)),
                            ]);
                          }).toList()
                          
                          );
  }
  
  Widget _buildUpperSegment(BuildContext context) {
    return Row(
              children: [
                

                Expanded(
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                    children: 
                            [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                
                                IconButton(onPressed: () => exitStudy(context), icon: Icon(Icons.close)),

                                  Expanded(child: Slider(
                                    activeColor: t.isActive ? null : Colors.grey,
                                    thumbColor: t.isActive ? null : Colors.grey,
                                    divisions: timeInterval,
                                    value: secondsRemaining / timeInterval, onChanged: (value) {
                                    setState(() {
                                      secondsRemaining = (value * timeInterval).floor();
                                    });
                                  })),
                
                                  Text("Next card in: "),
                                  Container(
                                  height: 50,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          
                                        Text(getTimeString(secondsRemaining), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                     
                                      ]), 
                                        
                                    ),
                                  ),
                                )
                                ]),
                              ),
                    
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: 
                              [
                                  TextButton(
                                    child: Row(children: [
                                      Text("Fast Forward"), Icon(Icons.fast_forward)
                                    ]),
                                    onPressed: (){ advanceTime(); },)
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: 
                              [
                                  TextButton(
                                    child: Row(children: [
                                      Text(t.isActive ? "Pause" : "Resume"), 
                                      Icon(t.isActive ? Icons.pause : Icons.play_arrow)
                                    ]),
                                    onPressed: (){
                                       toggleTimer(); 
                                       },)
                              ]),
                            ]
                            ),
                ),
              ],
            );
  }

  void exitStudy(BuildContext context) {
    t.cancel();
    Navigator.of(context).pop();
  }
  
  Widget _buildStudySummary(BuildContext context) {
    
    final double fontSize = 28; // TODO: Extract to style
    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: 
                          [
                            Text('${flashcardsResults.length} cards done', style: TextStyle(color: Colors.black, fontSize: fontSize),),
                            Text('${flashcardsResults.where((r) => r.correct).length} correct', style: TextStyle(color: Colors.green, fontSize: fontSize)),
                            Text('${flashcardsResults.where((r) => !r.correct).length} incorrect', style: TextStyle(color: Colors.red, fontSize: fontSize)),
                        ],)),
                      ),
                    );
  }
  
  

  

}



