

import 'dart:collection';
import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/navigation/route_generator.dart';
import 'package:flashcard_desktop_app/src/services/app_database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:get_it/get_it.dart';

import '../custom/data/abstract/database_service.dart';
import '../model/entities/deck.dart';
import '../model/entities/flashcard.dart';
import '../window/app_window_manager.dart';

class FlashcardDirectoriesListingView extends StatefulWidget {
  const FlashcardDirectoriesListingView({super.key});

  @override
  State<FlashcardDirectoriesListingView> createState() => _FlashcardDirectoriesListingViewState();
}

class _FlashcardDirectoriesListingViewState extends State<FlashcardDirectoriesListingView> {

  bool isLoading = true;

  DeckService flashcardDirectoryService = GetIt.I.get<DeckService>();

  @override
  void initState() async {
    super.initState();
    await flashcardDirectoryService.getAllDecks();
    }

  WindowManagerWrapper get windowManager => GetIt.I.get<WindowManagerWrapper>(); 

  List<String> selectedDirectoryIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Browse Decks", style: TextStyle(color: Colors.black)),
      shadowColor: const Color.fromARGB(0, 0, 0, 0),),
      body: FutureBuilder(
        future: GetIt.I.get<DeckService>().getAllDecks(),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if(snapshot.hasError) return const Center(child: Text("There was an error"));
    
          final data = snapshot.data!;
          //final node = buildTree(data, (dir) => dir.path);
          //final _treeController = TreeViewController(children: node.children, selectedKey: '');

          return Column(children: [

            Expanded(
              child: TreeView(
                controller: TreeViewController(), // _treeController,
                  nodeBuilder: (context, node)
                  {
                    final Deck? data = node.data;
                    if(data != null)
                    {
                      return ListTile(
                        onTap: () => toggleDirectorySelected(data.id!),
                        title: Text(node.label), trailing: Checkbox(
                        value: selectedDirectoryIds.contains(data.id),
                        onChanged: (value) {
                          toggleDirectorySelected(data.id!);
                      }));
                    }
                    return ListTile(title: Text(node.label));
            
                  },
                  
                  ),
            ),

            selectedDirectoryIds.isEmpty ? Container()
           : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextButton(onPressed:() => onBeginStudy(context), 
             child: Container(
              height: 45,
              width: 150,
              child: Center(child: Text('Begin Study (${selectedDirectoryIds.length})')))),
           )
           ],)

          ]);
    
    
        }),
    );
  }

  void onBeginStudy(context) {
    Navigator.pushNamed(context, RouteGenerator.studyRoute, arguments : {'flashcardDirectoryIds' : selectedDirectoryIds});
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