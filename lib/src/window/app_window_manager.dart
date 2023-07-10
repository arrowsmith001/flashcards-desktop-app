

import 'dart:async';

import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class AppWindowManager with WindowListener
{

  AppWindowManager(){
    windowManager.addListener(this);
  }

  WindowOptions defaultOptions = const WindowOptions(
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  Size windowSize = defaultSize;

  @override
  void onWindowResize() {
    super.onWindowResize();
    windowManager.getSize().then((value) => windowSize = value);
  }

  @override
  void onWindowEvent(String eventName) {
    super.onWindowEvent(eventName);
    _windowEventStreamController.sink.add(eventName);
  }

  final StreamController<String> _windowEventStreamController = StreamController.broadcast();
  Stream<String> get windowEvents => _windowEventStreamController.stream;

  

  

  Size currentSize = defaultSize;

  static const Size defaultSize = Size(1500, 800);
  static const Size notificationModeSize = Size(400, 150);

  WindowManager get windowManager => WindowManager.instance;

  Future<void> blur() => windowManager.blur();
  
  Future<void> dismissAndMakeInvisible() async {
     
    final futures = <Future>[windowManager.blur(), windowManager.setOpacity(0), windowManager.setAlwaysOnBottom(true)];

      await Future.wait(futures); 
  }

  Future<void> makeVisible() async {
    final futures = <Future>[windowManager.setOpacity(1)]
      ;

    await Future.wait(futures);
  }

  Future<void> setDefaultSizeAndPosition({hide = false}) async
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

  Future<void> setNotificationModeSizeAndPosition() async
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

  void minimize() {
    windowManager.minimize();
  }

  Future<bool> isMaximised() => windowManager.isMaximized(); 
  Future<bool> isMinimized() => windowManager.isMinimized(); 

  void maximize() {
    windowManager.isMaximized()
      .then((maximized) => 
        maximized ? windowManager.unmaximize() :  windowManager.maximize());
    
  }
  void close() {
    windowManager.close();
  }

  Future<void> drag() async {
    await windowManager.startDragging();
  }

  Future<void> initialize() async {
     await windowManager.ensureInitialized();
     await windowManager.waitUntilReadyToShow(defaultOptions, () async {
        await setDefaultSizeAndPosition();               
        await windowManager.show();
        await windowManager.focus();
      });
  }
  

}