

import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/navigation/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

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
        title: const Text("Browse Decks", style: TextStyle(color: Colors.black)),
        backgroundColor: ThemeData.light().scaffoldBackgroundColor, 
      shadowColor: const Color.fromARGB(0, 0, 0, 0),),
      body: FutureBuilder(
        future: fetchFlashcardDirectories(),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          if(snapshot.hasError) return const Center(child: Text("There was an error"));
    
          final data = snapshot.data!;
    
          return Stack(children: [

            TreeView(
              controller: TreeViewController(children:[data], selectedKey: ''),),
    

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
    
            directoryIds.isEmpty ? Container() 
            : Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(child: const Text('Begin Study'),
              onPressed: () 
              {
                Navigator.pushNamed(context, NavigationManager.studyRoute, arguments : {'flashcardDirectoryIds' : directoryIds});
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


  Future<Node<FlashcardDirectory?>> fetchFlashcardDirectories() async {

    // return Node(key: '', label: '0', children: [

    //     Node(key: '1', label: '1', data: FlashcardDirectory('id', '1', 0)),
    //     Node(key: '2', label: '2', data: FlashcardDirectory('id', '2', 0)),
    //     Node(key: '3', label: '3', data: FlashcardDirectory('id', '3', 0)),
    //     Node(key: '4', label: '4', data: FlashcardDirectory('id', '4', 0)),
    // ]);

    final docs = await Firestore.instance.collection("flashcardDirectories").limit(3).get();
    
    // Now we have a list of unconnected directories
    final directoriesListed = docs.map(FlashcardDirectory.fromFirestoreDocument).toList();

    // Organize into folder structure
    directoriesListed.sort((d1, d2) => d1.path.toLowerCase().compareTo(d2.path.toLowerCase()));

    SimpleNode simpleNode = getSimpleNodeTreeFromDirectories(directoriesListed);
  
    try{

    //Map<String, Node<FlashcardDirectory?>> nodes = {};
    List<Node<FlashcardDirectory?>> nodes = [];
    List<String> topLevels = [];

    Map<String, dynamic> structure = {};
    for(var dir in directoriesListed)
    {
      final dirNames = dir.path.split('/');
      structure = addRecursively(structure, dirNames);

/*       AppLogger.log("3");
      nodes.add(Node<FlashcardDirectory?>(key: dir.path, label: dir.name, data: dir));
        
      AppLogger.log("4");
      String topLevel = dir.path.split('/').reduce((v, e) {
        final subPath = "$v/$e";
        if(!nodes.any((element) => element.key == subPath))
        { 
          nodes.add(Node<FlashcardDirectory?>(key: subPath, label: subPath.split('/').last, data: null));
          AppLogger.log("subPath: " + subPath.toString());
        }
    
        return subPath;
      });

      nodes.add(Node<FlashcardDirectory?>(key: topLevel, label: topLevel, data: null));
      topLevels.add(topLevel); */
    }

    Map<String, dynamic> nodeTree = {};
    for(var dir in directoriesListed)
    {
      final splitPath = dir.path.split('/');
     // addNodesRecursively(nodeTree, dir, splitPath);
    }


    AppLogger.log("pathsToNodes: " + nodes.toString());


    final rootNode = Node<FlashcardDirectory?>(key: '', label: '', data: null);
    rootNode.children.addAll(nodes.where((element) => topLevels.contains(element.key)));
    AppLogger.log("node: " + rootNode.toString());

    return rootNode;
    }on Exception catch(e)
    {
        AppLogger.log(e.toString());
    }

    return Node(key: '', label: '', data: new FlashcardDirectory('id', 'path', 0));


  }
  
  SimpleNode getSimpleNodeTreeFromDirectories(List<FlashcardDirectory> directoriesListed) {
    SimpleNode root = SimpleNode<FlashcardDirectory?>('', null);
    for(var dir in directoriesListed)
    {
      final splitPath = dir.path.split('/');

      addToTree(root, splitPath);

    }
  }
  
  // TODO: Figure out how to make tree structure 

  SimpleNode<FlashcardDirectory?> addToTree(SimpleNode current, List<String> splitPath, FlashcardDirectory directory) {
    
    final currentName = splitPath.first;
    if(splitPath.length == 1) return SimpleNode<FlashcardDirectory?>(currentName, directory);

    late SimpleNode child;
    try
    {
      child = current.children.singleWhere((element) => element.name == currentName);
      child.children.add(SimpleNode<FlashcardDirectory?>(currentName, null), splitPath.sublist(1), directory);
    }catch (e){}

    current.children.add(addToTree(SimpleNode<FlashcardDirectory?>(currentName, null), splitPath.sublist(1), directory));
    
  }
  
/*   Node addNodesRecursively(Map<String, dynamic> struct, Node currentNode, FlashcardDirectory dir, int depth) {
    
    final splitPath = dir.path.split('/');
    
    if(splitPath.length < depth)
    {
      return Node(key: dir.path, label: dir.name, data: dir);
    }

    final nextMap = struct[splitPath[depth]]; 


    final current = path.first;
    late Node node;
    if(!struct.containsKey(current))
    {
      node = Node();
      node = struct[currentNode];
    }
    else 

  } */


}


class SimpleNode<T> {
  final T data;
  final String name;

  List<SimpleNode> children = [];

  SimpleNode(this.name, this.data);
}