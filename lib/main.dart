
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/custom/data/auth_service.dart';
import 'package:flashcard_desktop_app/src/custom/data/database_service.dart';
import 'package:flashcard_desktop_app/src/services/app_database_service.dart';
import 'package:flashcard_desktop_app/src/window/app_window_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'src/app.dart';

GetIt get g => GetIt.I;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencyInjection();

  await g.get<WindowManagerWrapper>().initialize();

  runApp(MyApp());
}

Future<void> configureDependencyInjection() async
{
  configureAbstractDependencies();
  configureConcreteDependencies();

  await g.allReady();

}

void configureAbstractDependencies() {

  g.registerSingletonAsync<AppConfigManager>(() async {
    final config = AppConfigManager();
    await config.configureForEnvironment('dev');
    return config;
  });
  g.registerSingletonAsync<WindowManagerWrapper>(() async => WindowManagerWrapper());


  g.registerSingletonAsync<AppDatabaseService>(() async => g.getAsync<AppFirebaseService>());
  g.registerSingletonAsync<AppDataStore>(() async => AppDataStore(await g.getAsync<AppDatabaseService>()), 
    dependsOn: [AppDatabaseService]);

  g.registerSingletonAsync<AppAuthService>(() async => g.getAsync<AppFirebaseService>());
  

}


void configureConcreteDependencies() {  
  
  g.registerSingletonAsync<AppFirebaseService>(() async 
  {
      final service = AppFirebaseService();
      await service.initialize(await g.getAsync<AppConfigManager>());
      return service;
  }, dependsOn: [AppConfigManager]);
}
