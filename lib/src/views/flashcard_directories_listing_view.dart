

import 'dart:collection';
import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../model/flashcard.dart';

//TODO: TREE STRUCTURE FFS

class FlashcardDirectoriesListingView extends StatefulWidget {
  const FlashcardDirectoriesListingView({super.key});

  @override
  State<FlashcardDirectoriesListingView> createState() => _FlashcardDirectoriesListingViewState();
}

class _FlashcardDirectoriesListingViewState extends State<FlashcardDirectoriesListingView> {

List<String> selectedDirectoryIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse Decks", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(onPressed: () {

          }, icon: Icon(Icons.expand))
        ],
        backgroundColor: ThemeData.light().scaffoldBackgroundColor, 
      shadowColor: const Color.fromARGB(0, 0, 0, 0),),
      body: FutureBuilder(
        future: fetchFlashcardDirectories(),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if(snapshot.hasError) return const Center(child: Text("There was an error"));
    
          final data = snapshot.data!;
          final node = buildTree(data, (dir) => dir.path);
          final _treeController = TreeViewController(children: node.children, selectedKey: '');

          return Stack(children: [

            TreeView(
              controller: _treeController,
                nodeBuilder: (context, node)
                {
                  final FlashcardDirectory? data = node.data;
                  if(data != null)
                  {
                    return ListTile(
                      onTap: () => toggleDirectorySelected(data.id),
                      title: Text(node.label), trailing: Checkbox(
                      value: selectedDirectoryIds.contains(data.id),
                      onChanged: (value) {
                        toggleDirectorySelected(data.id);
                    }));
                  }
                  return ListTile(title: Text(node.label));

                },
                
                ),

                

/*             ListView(children: data.map((dir) {
              
                  final id = dir.id;

            return ListTile(
              title: Text(dir.path),
              leading: id == null ? Container() :  Checkbox(
              value: directoryIds.contains(dir.id),
              onChanged: (value) {
              setState(() {
                  if(!directoryIds.contains(id)){ directoryIds.add(id); }
                  else { directoryIds.remove(id); }
              });
            }),
          );
            }).toList()), */
    
            selectedDirectoryIds.isEmpty ? Container() 
            : Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(child: Text('Begin Study (${selectedDirectoryIds.length})'),
              onPressed: () 
              {
                Navigator.pushNamed(context, NavigationManager.studyRoute, arguments : {'flashcardDirectoryIds' : selectedDirectoryIds});
              }),
          
            )
          ]);
    
    
        }),
    );
  }


  Future<List<FlashcardDirectory>> fetchFlashcardDirectories() async {


    final docs = await Firestore.instance.collection("flashcardDirectories").limit(10).get();
    
    // Now we have a list of unconnected directories
    final directoriesListed = docs.map(FlashcardDirectory.fromFirestoreDocument).toList();

    // Organize into folder structure
    directoriesListed.sort((d1, d2) => d1.path.toLowerCase().compareTo(d2.path.toLowerCase()));

    return directoriesListed;
  

}


Node<T?> buildTree<T>(List<T> dataList, String Function(T) getPath) {

  AddableTreeNode<T> root = AddableTreeNode<T>(key: '', label: '');

  for (T data in dataList) {

    final String path = getPath(data);
    List<String> parts = path.split('/');
    AddableTreeNode<T> currentNode = root;

    String builtUpName = "";

    for (String part in parts) {

      AddableTreeNode<T> nextNode;
      builtUpName = "$builtUpName/$part";

      if(currentNode.children.any((node) => node.key == builtUpName))
      {
        nextNode = currentNode.children
            .firstWhere((node) => node.key == builtUpName);
      }
      else
      {
        nextNode = AddableTreeNode(key: builtUpName, label: part);
        currentNode.children.add(nextNode);
      }

        currentNode = nextNode;
      }

      currentNode.data = data;
    }

    return convertToImmutableTree<T>(root);
  }

  
Node<T> convertToImmutableTree<T>(AddableTreeNode<T> addableNode) {
  T? data = addableNode.data;
  List<Node<T>> children = addableNode.children
      .map((child) => convertToImmutableTree(child))
      .toList();
  return Node(children: children, data: data, key: addableNode.key, label: addableNode.label, expanded: true);
}

  void toggleDirectorySelected(String id) {
        setState(() {
            if(!selectedDirectoryIds.contains(id)) selectedDirectoryIds.add(id);
            else selectedDirectoryIds.remove(id);
          });
  }
  
  

}


class AddableTreeNode<T> {

  final String key;
  final String label;
  T? data;
  final List<AddableTreeNode<T>> children = [];

  AddableTreeNode({required this.key,required this.label, this.data});
}