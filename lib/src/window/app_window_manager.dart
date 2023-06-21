import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

// TODO: Fix issue where window isn't resizable after dismissing a notification
class AppWindowManager 
{
  static const Size defaultSize = Size(800, 500);
  static const Size notificationModeSize = Size(400, 150);

  static WindowManager get windowManager => WindowManager.instance;

  static Future<void> dismissAndMakeInvisible() async {
     
    final futures = <Future>[]
      ..add(windowManager.blur())
      ..add(windowManager.setOpacity(0))
      ..add(windowManager.setAlwaysOnBottom(true))
      ;

      await Future.wait(futures); 
  }

  static Future<void> makeVisible() async {
    final futures = <Future>[]
      ..add(windowManager.setOpacity(1));

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


    await Future.wait(futures);
    
  }

  static Future<void> setNotificationModeSizeAndPosition() async
  {

    await windowManager.setOpacity(0);

    final futures = <Future>[]
      ..add(windowManager.setAsFrameless())
      ..add(windowManager.setHasShadow(false))
      ..add(windowManager.setSize(notificationModeSize))
      ..add(windowManager.setAlignment(Alignment.bottomRight))
      ..add(windowManager.setPosition(Offset.zero))
      ..add(windowManager.setAlwaysOnTop(true));

    await Future.wait(futures);
    
    futures..clear()
      ..add(windowManager.show())
      ..add(windowManager.focus())
      ..add(windowManager.setOpacity(1));

    await Future.wait(futures);
  }

}