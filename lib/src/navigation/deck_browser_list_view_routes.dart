import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/providers/app_state_providers.dart';
import 'package:flashcard_desktop_app/src/views/deck_management/deck_browser.dart';
import 'package:flashcard_desktop_app/src/views/deck_management/deck_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckBrowserListViewRoutes {
  static Route generateRoute(RouteSettings settings) {
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 200),
        reverseTransitionDuration: Duration(milliseconds: 200),
        settings: settings,
        pageBuilder: (context, anim, anim2) {

          
          return ProviderScope(
              overrides: [
                getCurrentPathProvider.overrideWithValue(settings.name!)
              ],
              child: DecksListView());
        },
        transitionsBuilder: (context, anim, anim2, child) 
        {

/*           CurvedAnimation curvedIn =
              CurvedAnimation(parent: anim, curve: Curves.decelerate);
          CurvedAnimation curvedOut =
              CurvedAnimation(parent: anim2, curve: Curves.decelerate); */

              final tween = Tween<Offset>(end: Offset.zero, begin: Offset(1, 0)).chain(CurveTween(curve: Curves.decelerate));
              return Opacity(
                opacity: anim.value,
                child: SlideTransition(position: anim.drive(tween), child: child,));
          
        });
  }
}
