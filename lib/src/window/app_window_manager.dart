
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

// TODO: Implement own resizing/window dragging method
class AppWindowManager with WindowListener
{
  static AppWindowManager instance = AppWindowManager._();
  AppWindowManager._(){
    windowManager.addListener(this);
  }
  factory AppWindowManager() => instance;

  Size windowSize = defaultSize;

  @override
  void onWindowResize() {
    super.onWindowResize();
    windowManager.getSize().then((value) => windowSize = value);
  }
  

  Size currentSize = defaultSize;

  static const Size defaultSize = Size(800, 500);
  static const Size notificationModeSize = Size(400, 150);

  static WindowManager get windowManager => WindowManager.instance;

  static Future<void> blur() => windowManager.blur();
  
  static Future<void> dismissAndMakeInvisible() async {
     
    final futures = <Future>[windowManager.blur(), windowManager.setOpacity(0), windowManager.setAlwaysOnBottom(true)]
      
      
      
      ;

      await Future.wait(futures); 
  }

  static Future<void> makeVisible() async {
    final futures = <Future>[windowManager.setOpacity(1)]
      ;

    await Future.wait(futures);
  }

  static Future<void> setDefaultSizeAndPosition({hide = false}) async
  {
    final futures = <Future>[];

    futures
      ..add(windowManager.setResizable(true))
      ..add(windowManager.setOpacity(1))
      ..add(windowManager.setHasShadow(true))
      ..add(windowManager.setSize(defaultSize))
      ..add(windowManager.setAlignment(Alignment.center))
      ..add(windowManager.setAlwaysOnTop(false))
      ..add(windowManager.setAlwaysOnBottom(false));


    for(var f in futures)
    {
      await f;
    }

    
    
  }

  static Future<void> setNotificationModeSizeAndPosition() async
  {

    await windowManager.setOpacity(0);

    final futures = <Future>[
      windowManager.setAsFrameless(), 
      windowManager.setHasShadow(false), 
      windowManager.setSize(notificationModeSize), 
      windowManager.setAlignment(Alignment.bottomRight),
      windowManager.setPosition(Offset.zero),
      windowManager.setAlwaysOnTop(true)
      ];

    for(var f in futures)
    {
      await f;
    }

    futures..clear()
      ..add(windowManager.show())
      ..add(windowManager.focus())
      ..add(windowManager.setOpacity(1));

        for(var f in futures)
    {
      await f;
    }

  }

}