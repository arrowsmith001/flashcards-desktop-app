import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:window_manager/window_manager.dart';

import '../model/flashcard.dart';

Logger logger = Logger();

class FlashcardViewModel extends StatefulWidget {
  FlashcardViewModel(this.flashcard, {super.key});
  

  final Flashcard flashcard;
  @override
  State<FlashcardViewModel> createState() => _FlashcardViewModelState();
}

class _FlashcardViewModelState extends State<FlashcardViewModel>
    with SingleTickerProviderStateMixin, WindowListener {
  late AnimationController _controller;
  
  Flashcard get flashcard  => widget.flashcard;

  @override
  void onWindowFocus() {
    super.onWindowFocus();
    logger.d("focus");
  }

  @override
  void initState() {
    super.initState();
    _controller =  AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    // _controller.addListener(() {
    //   setState(() {
    //     windowManager.setSize(Size(300*_controller.value, 150*_controller.value));  
    //   });
    // });
    windowManager.addListener(this);
  }


  @override
  void dispose() {
    _controller.dispose();
    windowManager.removeListener(this);
    super.dispose();
  }

  Future<bool> initWindow() async
  {
      await windowManager.hide();
      var futures = [
      windowManager.setAlwaysOnTop(true),
      windowManager.setSize(Size(300,150)),
      windowManager.setAlignment(Alignment.bottomRight),
      windowManager.setMinimizable(false),
      windowManager.focus()
      ];
      await Future.wait(futures);
      await windowManager.show();
      

      _controller.drive(CurveTween(curve: Curves.easeInOut));

      return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initWindow(),
      builder: (context, snap) {
        return Scaffold(
             // backgroundColor: Colors.white.withAlpha(0),

              body: Align(
                alignment: Alignment.bottomRight,
                child: Transform.scale(
                scale: 1 - _controller.value,
                child: Center(child: Column(children: [
                  Text(flashcard.prompt),
                  TextButton(onPressed: () {Navigator.pop(context); }, child: Text("X"))
                ],))
                
                ),
              ),
        ); 
            } );
      }
    
  }
