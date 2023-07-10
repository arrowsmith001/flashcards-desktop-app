import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/views/flashcard_directories_listing_view.dart';
import 'package:flashcard_desktop_app/src/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import 'settings_view.dart';


class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView>
    with SingleTickerProviderStateMixin {

  late AnimationController _assemblyAnimationController;
  late Animation<double> _assemblyAnimation;

  
  bool _isNavigationRailExtended = true;
  int _selectedIndex = 0;
  

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _assemblyAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));   
    _assemblyAnimationController.addListener(() {setState(() {});});
    _assemblyAnimation = CurvedAnimation(parent: _assemblyAnimationController, curve: Curves.easeInOut);

    _assemblyAnimationController.forward();
  }

  // TODO: Consider a splash screen into main screen route
  void _listenForTransitionEnd(BuildContext context) {
    var route = ModalRoute.of(context);
    void handler(status) {
      if (status == AnimationStatus.completed) {
        _assemblyAnimationController.forward();
        route!.animation!.removeStatusListener(handler);
        onTransitionEnded();
      }
    }
    route!.animation!.addStatusListener(handler); 
  }

    void onTransitionEnded() {
    AppLogger.log('hi');
    showDialog(context: context, builder: (context) {
      return LoginView();
    }); 
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
          case 0: return FlashcardDirectoriesListingView(ref.watch(flashcardDeckListingControllerProvider.notifier));
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