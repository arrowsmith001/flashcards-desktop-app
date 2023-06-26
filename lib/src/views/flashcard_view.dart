import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/model/flashcard.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/material.dart';

class FlashcardView extends StatefulWidget {
  FlashcardView(this.flashcard, {super.key});

  final Flashcard flashcard;
  final _navKey = GlobalKey<NavigatorState>();

  @override
  State<FlashcardView> createState() => _FlashcardViewState();
}

class _FlashcardViewState extends State<FlashcardView>
    with SingleTickerProviderStateMixin {

  Flashcard get flashcard  => widget.flashcard;

  late AnimationController _entryAnimationController;
  late CurvedAnimation curvedAnim;

  dismissFlashcard() async
  {
    setState(() {
      transitioningBack = true;
    });
    await AppWindowManager.dismissAndMakeInvisible().then((value) => Navigator.of(context, rootNavigator: true).pop());
  }

  @override
  void initState() {
    super.initState();

    _entryAnimationController = AnimationController(
      vsync: this, 
      value: 1, 
      duration: const Duration(milliseconds: 500));
    _entryAnimationController.addListener(() {setState(() {
    });});

    curvedAnim = CurvedAnimation(parent: _entryAnimationController, curve: Curves.easeOut);
    
    AppWindowManager.setNotificationModeSizeAndPosition().then((v) => _entryAnimationController.animateTo(0));
  }

  @override
  void dispose() {
    _entryAnimationController.dispose();
    curvedAnim.dispose();
    super.dispose();
  }     

  bool transitioningBack = false;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(AppWindowManager.notificationModeSize.width * curvedAnim.value, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Scaffold(
              body: transitioningBack ? const Center(child: CircularProgressIndicator()) 
              : Navigator(
                  key: widget._navKey,
                  initialRoute: '/prompt',
                  onGenerateRoute: (settings){
                      final args = settings.arguments as Map<String, dynamic>?;
                      switch(settings.name)
                      {
                        case '/prompt':
                        {
                          return PageRouteBuilder(
                            pageBuilder: (context, a1, a2) => buildPrompt(context, a1, a2),
/*                             transitionsBuilder: (_, anim1, anim2, child){

                              final double windowWidth = AppWindowManager.notificationModeSize.width; 
                              return Transform.translate(
                                    offset: Offset(windowWidth*(1-anim1.value),0),
                                    child: Transform.translate(
                                    offset: Offset(-windowWidth*(anim2.value),0),
                                    child: child));
                            } */
                            );
                        }
                        case '/response':
                        {
                          return PageRouteBuilder(
                            pageBuilder: (context, a1, a2) => buildResponse(context, a1, a2),
/*                             transitionsBuilder: (_, anim1, anim2, child){

                              final double windowWidth = AppWindowManager.notificationModeSize.width; 
                              return Transform.translate(
                                    offset: Offset(windowWidth*(1-anim1.value),0),
                                    child: child);
                            } */
                            );
                        }
                      }

                  }
              )),
          ),
        ));
  }
  
  double get windowWidth => AppWindowManager.notificationModeSize.width; 

  Widget buildPrompt(BuildContext context, Animation<double> anim1, Animation<double> anim2) {
    AppLogger.log("prompt: ${anim1.value} ${anim2.value}");

        return InkWell(
            hoverColor: Colors.grey.shade300,
            onTap: () => Navigator.of(widget._navKey.currentContext!).pushNamed('/response'),
            child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: 
              [
                Expanded(
                  child: Transform.translate(
                      offset: Offset(windowWidth*(1-anim1.value),0),
                      child: Text(flashcard.prompt, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                )
                ,

                FadeTransition(
                  opacity: anim1,
                  child: Container(decoration: const BoxDecoration(
                            shape: BoxShape.rectangle),
                        child: const Icon(Icons.arrow_forward, color: Colors.black),
                      ),
                )
              ])
          ),
              
          ),
            );
  }  
  Widget buildResponse(BuildContext context, Animation<double> anim1, Animation<double> anim2) {
    AppLogger.log("response: ${anim1.value} ${anim2.value}");
        return InkWell(
            hoverColor: Colors.grey.shade300,
            onTap: () => dismissFlashcard(),
            child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: 
              [
                Expanded(
                  child: Transform.translate(
                      offset: Offset(windowWidth*(anim1.value),0),
                      child: Text(flashcard.response, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                )
                ,

                 FadeTransition(
                  opacity: anim1,
                  child: Container(decoration: const BoxDecoration(
                            shape: BoxShape.rectangle),
                        child: const Icon(Icons.close, color: Colors.black),
                      ),
                               )
              ])
          ),
              
          ),
            );
  }
  
}