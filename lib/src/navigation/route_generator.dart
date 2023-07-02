import 'package:flashcard_desktop_app/src/model/entities/flashcard.dart';
import 'package:flashcard_desktop_app/src/views/flashcard_directories_listing_view.dart';
import 'package:flashcard_desktop_app/src/views/flashcard_view.dart';
import 'package:flashcard_desktop_app/src/views/main_view.dart';
import 'package:flashcard_desktop_app/src/views/study_view.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../views/login_view.dart';


class RouteGenerator {

  static const String entryRoute = '/';
  static const String mainRoute = '/main';
  static const String studyRoute = '/study';
  static const String flashcardRoute = '/flashcard';

  static Route generateRoute(RouteSettings settings){
    final args = (settings.arguments as Map?);
    
    switch(settings.name){
      case entryRoute:
        return  PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (BuildContext context,Animation<double> animation,
                Animation<double> secondaryAnimation){
              return const LoginView();
            },
            transitionsBuilder: (_, Animation<double> animation, Animation<double> second, Widget child) {
              
              CurvedAnimation curvedIn = CurvedAnimation(parent: animation, curve: Curves.decelerate);
              CurvedAnimation curvedOut = CurvedAnimation(parent: second, curve: Curves.decelerate);

              
              return Scaffold(
                body: FadeTransition(
                  opacity: curvedIn,
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 1.0, end: 0.0).animate(curvedOut),
                    child: Transform.translate(
                      offset: Offset(500*(1-curvedIn.value),0),
                      child: Transform.translate(
                        offset: Offset(500*curvedOut.value,0),
                        child: child),
                    ),
                  )),

                  );


            }
        );
      case mainRoute:
        return  PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (BuildContext context,Animation<double> animation,
                Animation<double> secondaryAnimation){
              return const MainView();
            },
            transitionsBuilder: (_, Animation<double> animation, Animation<double> second, Widget child) {
              
              final double windowWidth = GetIt.I.get<WindowManagerWrapper>().windowSize.width; 
                      
              CurvedAnimation curvedIn = CurvedAnimation(parent: animation, curve: Curves.decelerate);
              CurvedAnimation curvedOut = CurvedAnimation(parent: second, curve: Curves.decelerate);

              return Scaffold(
                body: FadeTransition(
                  opacity: curvedIn,
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 1.0, end: 0.0).animate(curvedOut),
                    child: Transform.translate(
                      offset: Offset(windowWidth*(1-curvedIn.value),0),
                      child: Transform.translate(
                        offset: Offset(windowWidth*curvedOut.value,0),
                        child: child),
                    ),
                  )),

                  );

            }
        );
      case studyRoute:
        return  PageRouteBuilder(
          transitionDuration: Duration.zero,
            pageBuilder: (BuildContext context,Animation<double> animation,
                Animation<double> secondaryAnimation){
              return StudyView(args!['flashcardDirectoryIds']);
            }
            
        );
      case flashcardRoute:
        return  PageRouteBuilder<bool>(
          transitionDuration: Duration.zero,
            pageBuilder: (BuildContext context,Animation<double> animation,
                Animation<double> secondaryAnimation)
                {
                  final flashcard = Flashcard.deserialize(args!['flashcard']);
                  return FlashcardView(flashcard);
            }
        );
    }
    return unKnownRoute(settings);
  }

  static Route unKnownRoute(RouteSettings settings){
    return PageRouteBuilder(
        pageBuilder: (BuildContext context,Animation<double> animation,
            Animation<double> secondaryAnimation){
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("First Page",textDirection: TextDirection.ltr,),
                const Padding(padding: EdgeInsets.all(10.0)),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    color:material.Colors.blue,
                    child: const Text("Back"),
                  ),
                )
              ]
          );
        }
    );
  }

}

