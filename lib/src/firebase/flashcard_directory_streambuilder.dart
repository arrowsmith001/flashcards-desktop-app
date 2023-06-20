
import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/app.dart';
import 'package:flashcard_desktop_app/src/model/flashcard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../viewmodels/flashcard_directory_viewmodel.dart';

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
        '/study' : (context) => studyScreen(context),
      });
     
      }
      
        bool containsMe(FlashcardDirectory dir) {
          return flashcardDirectoriesSelectedChanged.directoryIds.contains(dir.path);
        }
      
  Widget studyScreen(BuildContext context) => Scaffold(
    body: FutureBuilder(
    future: loadFlashcards(),
    builder: (context, snap) {
      if(!snap.hasData || snap.hasError)
      {
        return Center(child: CircularProgressIndicator());
      }

      return ListView(children: flashcards.map((e) => ListTile(
      title: Text(e.prompt),
      subtitle: Text(e.response),
      )).toList());
    }),
  );


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
            : FloatingActionButton(onPressed:  () {
              Navigator.pushNamed(context, '/study');
            }, child: const Text("Begin Study")),
         );
         
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