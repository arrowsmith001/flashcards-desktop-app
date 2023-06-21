import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  bool isInitialized = false;  
  Future<bool> initializeDatabase() async {

    if(isInitialized) return true;

    var config = AppConfigManager.instance;

try{
      FirebaseAuth.initialize(config.apiKey!, VolatileStore());
    Firestore.initialize(config.projectId!); // Firestore reuses the auth client

    var auth = FirebaseAuth.instance;
    await auth.signIn(config.email!, config.password!);
}
catch(e){
  
}
    
    isInitialized = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: initializeDatabase(),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData)
          {
            return Center(child: CircularProgressIndicator());
          }
    
          if(snapshot.hasError)
          {
            return Center(child: Text("There was a Login error: ${snapshot.error.toString()}"));
          }
    
          return TextButton(onPressed: () => Navigator.pushNamed(context, '/flashcardDirectories'), 
          child: Center(child: Text("Login successful")));
        }),
    );
  }
}