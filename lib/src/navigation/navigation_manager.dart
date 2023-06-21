 import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/model/flashcard.dart';
import 'package:flashcard_desktop_app/src/views/flashcard_directories_listing_view.dart';
import 'package:flashcard_desktop_app/src/views/flashcard_view.dart';
import 'package:flashcard_desktop_app/src/views/study_view.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../views/login_view.dart';


class NavigationManager {

  static Route generateRoute(RouteSettings settings){
    final args = (settings.arguments as Map?);
    
    switch(settings.name){
      case "/":
        return  PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (BuildContext context,Animation<double> animation,
                Animation<double> secondaryAnimation){
              return LoginView();
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
                        child: child,
                      offset: Offset(500*curvedOut.value,0)),
                    ),
                  )),

                  );


            }
        );
        break;
      case "/flashcardDirectories":
        return  PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (BuildContext context,Animation<double> animation,
                Animation<double> secondaryAnimation){
              return FlashcardDirectoriesListingView();
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
                        child: child,
                      offset: Offset(500*curvedOut.value,0)),
                    ),
                  )),

                  );

              return Scaffold(
                body: FadeTransition(
                opacity: animation,
                child: FadeTransition(
                  opacity: Tween<double>(begin: 1.0, end: 0.0).animate(second),
                  child: child,
                ),
              ),
              );
            }
        );
      case "/study":
        return  PageRouteBuilder(
          transitionDuration: Duration(microseconds: 0),
            pageBuilder: (BuildContext context,Animation<double> animation,
                Animation<double> secondaryAnimation){
              return StudyView(args!['flashcardDirectoryIds']);
            }
            
        );
      case "/flashcard":
        return  PageRouteBuilder(
          transitionDuration: Duration(microseconds: 0),
            pageBuilder: (BuildContext context,Animation<double> animation,
                Animation<double> secondaryAnimation)
                {
                  final flashcard = Flashcard.deserialized(args!['flashcard']);
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
                const Padding(padding: const EdgeInsets.all(10.0)),
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

