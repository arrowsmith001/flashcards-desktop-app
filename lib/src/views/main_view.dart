import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/views/flashcard_directories_listing_view.dart';
import 'package:flutter/material.dart';

import 'settings_view.dart';


class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {

  late AnimationController _assemblyAnimationController;
  late Animation<double> _assemblyAnimation;

  
  bool _isNavigationRailExtended = true;
  int _selectedIndex = 0;
  

  @override
  void initState() {
    super.initState();
    _assemblyAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));   
    _assemblyAnimationController.addListener(() {setState(() {});});
    _assemblyAnimation = CurvedAnimation(parent: _assemblyAnimationController, curve: Curves.easeInOut);
  }

  void _listenForTransitionEnd(BuildContext context) {
    var route = ModalRoute.of(context);
    void handler(status) {
      if (status == AnimationStatus.completed) {
        _assemblyAnimationController.forward();
        route!.animation!.removeStatusListener(handler);
      }
    }
    route!.animation!.addStatusListener(handler);
  }

  @override
  void dispose() {
    _assemblyAnimationController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context) {
    _listenForTransitionEnd(context);

    final animationValue = _assemblyAnimation.value;
    final oneMinusAnimationValue = 1 - _assemblyAnimation.value;

    return Row(children: [

      Opacity(
        opacity: animationValue,
        child: Transform.translate(
            offset: Offset(-100 * oneMinusAnimationValue, 0),
            child: _buildNavigationRail(),
          ),
      ),

      VerticalDivider(),

      Expanded(
        child: Opacity(
        opacity: animationValue,
        child: Transform.translate(
            offset: Offset(500 * oneMinusAnimationValue, 0),
            child: _buildMainBody(),
          ),
      ),
      )
    ],);
  }

Widget _buildMainBody() {
  return Builder(builder: (context){
        switch(_selectedIndex)
        {
          case 0: return FlashcardDirectoriesListingView();
          case 1: return SettingsView();
        }
        return Placeholder();
      });
}

Widget _buildNavigationRail() {
  return NavigationRail(
            extended: _isNavigationRailExtended,
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
          selectedIndex: _selectedIndex);
}

}