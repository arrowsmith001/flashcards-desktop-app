import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/custom/data/auth_service.dart';
import 'package:flashcard_desktop_app/src/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/app_database_service.dart';
import '../window/app_window_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  WindowManagerWrapper get windowManager => GetIt.I.get<WindowManagerWrapper>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GetIt.I.get<AppAuthService>().authService.loginWithEmailAndPassword('arrowsmithalexander@gmail.com', '123456'),
        builder: (context, snapshot)
        {
          if(!snapshot.hasData)
          {
            return const Center(child: CircularProgressIndicator());
          }
    
          if(snapshot.hasError)
          {
            return Center(child: Text("There was a Login error: ${snapshot.error.toString()}"));
          }
    
          return TextButton(onPressed: () => Navigator.pushNamed(context, AppNavigation.mainRoute), 
          child: const Center(child: Text("Login successful")));
        }),
    );
  }
}