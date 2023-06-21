import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as material;

import '../model/flashcard.dart';

class FlashcardDirectoriesListingView extends StatefulWidget {
  const FlashcardDirectoriesListingView({super.key});

  @override
  State<FlashcardDirectoriesListingView> createState() => _FlashcardDirectoriesListingViewState();
}

class _FlashcardDirectoriesListingViewState extends State<FlashcardDirectoriesListingView> {

List<String> directoryIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Browse Decks", style: TextStyle(color: Colors.black)),
        backgroundColor: ThemeData.light().scaffoldBackgroundColor, 
      shadowColor: Color.fromARGB(0, 0, 0, 0),),
      body: FutureBuilder(
        future: fetchFlashcardDirectories(),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if(snapshot.hasError) return const Center(child: Text("There was an error"));
    
          final data = snapshot.data!;
    
          return Stack(children: [
            ListView(children: data.map((dir) {
              
            return ListTile(
              title: Text(dir.path),
              leading: Checkbox(
              value: directoryIds.contains(dir.id),
              onChanged: (value) {
              setState(() {
                  final id = dir.id;
                  if(!directoryIds.contains(id)){ directoryIds.add(id); }
                  else { directoryIds.remove(id); }
              });
            }),
          );
            }).toList()),
    
            directoryIds.isEmpty ? Container() 
            : Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(child: const Text('Begin Study'),
              onPressed: () 
              {
                Navigator.pushNamed(context, '/study', arguments : {'flashcardDirectoryIds' : directoryIds});
              }),
          
            ),


            Align(
              alignment: Alignment.topCenter,
              child: TextButton(child: const Text('<-->'),
              onPressed: () 
              {
                Navigator.pop(context);
              }),
          
            )
          ]);
    
    
        }),
    );
  }

  Future<List<FlashcardDirectory>> fetchFlashcardDirectories() async {
    final docs = await Firestore.instance.collection("flashcardDirectories").limit(3).get();
    
    final directoriesListed = docs.map(FlashcardDirectory.fromFirestoreDocument).toList();
    directoriesListed.sort((d1, d2) => d1.path.toLowerCase().compareTo(d2.path.toLowerCase()));
    return directoriesListed;
  }


}