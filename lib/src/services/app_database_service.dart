


import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/custom/data/auth_service.dart';
import 'package:flashcard_desktop_app/src/model/flashcard.dart';
import 'package:flashcard_desktop_app/src/custom/data/database_service.dart';
import 'package:get_it/get_it.dart';

import '../classes/app_config.dart';
import '../custom/data/firebase.dart';



class AppFirebaseService implements AppDatabaseService, AppAuthService
{
  Future<void> initialize(AppConfigManager config) async
  {
    FirebaseAuth.initialize(config.apiKey!, VolatileStore());
    Firestore.initialize(config.projectId!);
  }

  @override
  DatabaseService<FlashcardDirectory> flashcardDirectoryService = FirebaseLiteDatabaseService('flashcardDirectories', FlashcardDirectory.deserialize);

  @override
  DatabaseService<Flashcard> flashcardService = FirebaseLiteDatabaseService('flashcards', Flashcard.deserialize);
  
  @override
  AuthService get authService => FirebaseAuthService();
  

}

class AppDataStore
{
  AppDataStore(this.databaseService);
  final AppDatabaseService databaseService;

  List<FlashcardDirectory> getAllFlashcardDirectories(){
    throw UnimplementedError(); // TODO: Implement with cache
  }

  
}

abstract class AppDatabaseService 
{
  AppDatabaseService(this.flashcardDirectoryService, this.flashcardService);

  final DatabaseService<FlashcardDirectory> flashcardDirectoryService;
  final DatabaseService<Flashcard> flashcardService;
}


abstract class AppAuthService {
  AppAuthService(this.authService);
  final AuthService authService;
}
