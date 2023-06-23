import 'package:flashcard_desktop_app/src/views/flashcard_directories_listing_view.dart';
import 'package:flutter/material.dart';

import 'settings_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      NavigationRail(
        onDestinationSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
      destinations: const [
         NavigationRailDestination(
          icon:  Icon(Icons.book), 
          label: Text("My decks")),
        NavigationRailDestination(
          icon:  Icon(Icons.settings), 
          label: Text("Settings")),
      ], 
      selectedIndex: _selectedIndex),

      VerticalDivider(),

      Expanded(
        child: Builder(builder: (context){
          switch(_selectedIndex)
          {
            case 0: return FlashcardDirectoriesListingView();
            case 1: return SettingsView();
          }
          return Placeholder();
        }),
      )
    ],);
  }
}