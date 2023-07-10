

import 'dart:collection';
import 'dart:convert';

import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/widgets/card_window.dart';
import 'package:flashcard_desktop_app/src/model/entities/deck_collection.dart';
import 'package:flashcard_desktop_app/src/navigation/route_generator.dart';
import 'package:flashcard_desktop_app/src/services/app_database_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../../main.dart';
import '../custom/data/abstract/database_service.dart';
import '../model/entities/deck.dart';
import '../model/entities/flashcard.dart';
import '../model/entities/user.dart';
import '../services/app_deck_service.dart';
import '../window/app_window_manager.dart';


final flashcardDeckListingControllerProvider = StateNotifierProvider<FlashcardDeckListingNotifier, AsyncValue<List<DeckCollection>>>((ref) {
  return FlashcardDeckListingNotifier(ref.watch(deckServiceProvider));
});



class FlashcardDeckListingNotifier extends StateNotifier< AsyncValue<List<DeckCollection>>> {

  FlashcardDeckListingNotifier(this.deckService) : super(AsyncValue.data([]))
  {
    getAllCollections();
  }

  final AppDeckService deckService;

  Future<void> getAllCollections() async
  {
    state = const AsyncLoading();
    
    final collections = await deckService.getAllCollections();
    
    state = AsyncData(collections);
  }

  Future<void> addCollection(DeckCollection collection) async 
  {
    state = const AsyncLoading();
    
    await deckService.addDeckCollection(collection);
    final collections = await deckService.getAllCollections();

    state = AsyncData(collections);
  }
}

class FlashcardDirectoriesListingView extends ConsumerStatefulWidget {

  final FlashcardDeckListingNotifier controller;

  const FlashcardDirectoriesListingView(this.controller, {super.key});

  @override
  ConsumerState<FlashcardDirectoriesListingView> createState() => _FlashcardDirectoriesListingViewState();
}

class _FlashcardDirectoriesListingViewState extends ConsumerState<FlashcardDirectoriesListingView> {

  FlashcardDeckListingNotifier get controller => widget.controller;

  @override
  void initState() {
    super.initState();
  }

  
  bool isLoading = true;
  List<String> selectedDirectoryIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [

          Flexible(flex: 1, child: Container(),),

          Flexible(flex: 5,
            child: Row(children: 
            [
              Flexible(flex: 1, child: Container()),
          
              Flexible(flex: 6, child: _buildDeckBrowser(context)),
               
              Flexible(flex: 6,
                child: Column(children: [
                  Expanded(child: CardWindow(child: Container())),
                  Expanded(child: CardWindow(child: Container())),
                 ],),
              ),
          
              Flexible(flex: 1, child: Container()),
            ]),
          ),

          
          Flexible(flex: 1, child: Container(),),
        ],
      ),
    );
  }

  

  Widget _buildDeckBrowser(BuildContext context) {

    final deckCollectionListAsync = ref.watch(flashcardDeckListingControllerProvider);

    final loading = deckCollectionListAsync.isLoading;

    final deckCollectionList = deckCollectionListAsync.value;

    return CardWindow(child: 

 /*      Navigator(
        onGenerateRoute: (settings) => 
        PageRouteBuilder(pageBuilder: (context, _, __)
        {
            return  */

            Stack(
              fit: StackFit.expand,
              children: [

                Column(
                    children: [
                      Center(child: Column(children: 
                      [
                        Text('Add Deck Collection (${deckCollectionList?.length ?? '-'})'),
                        IconButton(onPressed: () {
                          onAddDeckCollection(context);
                        }, icon: Icon(Icons.add))],)),

                        Expanded(child: _buildDeckCollectionList(context, deckCollectionList ?? []))
                    ],
                  ),

                  loading ? Center(child: Container(color: const Color.fromARGB(144, 255, 255, 255))) : SizedBox.shrink()
              ],
            )) ;
        }
       
/*        ,
      )); */
  
    
  Widget _buildDeckCollectionList(BuildContext context, List<DeckCollection> collections) 
  {
      return ListView(
              children: collections.map((e) => ListTile(title: Text(e.name!))).toList());
  }

  Future<void> onAddDeckCollection(context) async 
  {   
    final notifier = ref.read(flashcardDeckListingControllerProvider.notifier);
    await notifier.addCollection(DeckCollection('id', null, 'My Decks', {}, true));
  }

  FutureBuilder<Object?> _oldBody() {
    return FutureBuilder(
      builder: (context, snapshot)
      {
        if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        if(snapshot.hasError) return const Center(child: Text("There was an error"));
  
/*           final data = snapshot.data!;
        final node = buildTree(data, (dir) => dir.path);
        final _treeController = TreeViewController(children: node.children, selectedKey: ''); */

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
  
  
      });
  }

  void onBeginStudy(context) {
    final AppWindowManager wm = ref.watch(windowManagerProvider);
    Navigator.pushNamed(context, RouteGenerator.studyRoute, arguments : {'flashcardDirectoryIds' : selectedDirectoryIds, 'windowSize' : wm.currentSize});
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