import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/navigation/route_generator.dart';
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
  void initState() {
    super.initState();
    textControllers["Email"]!.text = GetIt.I.get<AppConfigManager>().email!;
    textControllers["Password"]!.text = GetIt.I.get<AppConfigManager>().password!;
  }

  void navigateToMain(){
    Navigator.pushNamed(context, RouteGenerator.mainRoute);
  }

  Map<String, TextEditingController> textControllers = {
    "Email" : TextEditingController(),
    "Password" : TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [

        Column(children: [
        Text("Welcome", style: Theme.of(context).textTheme.bodyMedium),

        _buildTextField("Email"),
        _buildTextField("Password"),
        
        TextButton(onPressed: () => login(), child: Text("Login"))
      ]),

      !isLoggingIn ? SizedBox.shrink() 
      : Container(
        color: Theme.of(context).primaryColor.withAlpha(150),
        child: Center(child: CircularProgressIndicator()),
      )


      ]),
    );
  }

  Column _buildTextField(String textFieldName) {
    return Column(children: [
        Text(textFieldName),
        TextField(controller: textControllers[textFieldName])
      ]);
  }

  bool isLoggingIn = false;
  Future<void> login() async {
    setState(() {
      isLoggingIn = true;
    });

    final success = await GetIt.I.get<AuthService>().loginWithEmailAndPassword(textControllers['Email']!.text, textControllers['Password']!.text);
    
    setState(() {
      isLoggingIn = false;
    });

    if(success) navigateToMain();
  }
}