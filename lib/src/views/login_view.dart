import 'package:firedart/firedart.dart';
import 'package:flashcard_desktop_app/src/classes/app_config.dart';
import 'package:flashcard_desktop_app/src/classes/app_logger.dart';
import 'package:flashcard_desktop_app/src/custom/data/abstract/auth_service.dart';
import 'package:flashcard_desktop_app/src/navigation/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../custom/widgets/card_window.dart';
import '../custom/widgets/elevated_loadable_button.dart';
import '../model/entities/user.dart';
import '../services/app_database_service.dart';
import '../window/app_window_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final Map<String, TextEditingController> textControllers = {
    "Email" : TextEditingController(),
    "Password" : TextEditingController(),
  };

  bool isLoggingIn = false;

  @override
  void initState() {
    super.initState();
    textControllers["Email"]!.text = GetIt.I.get<AppConfigManager>().email!;
    textControllers["Password"]!.text = GetIt.I.get<AppConfigManager>().password!;
  }

  Future<void> login() async {
    setState(() { isLoggingIn = true; });

    try
    {
      final auth = GetIt.I.get<AuthService>();
      await auth.loginWithEmailAndPassword(textControllers['Email']!.text, textControllers['Password']!.text);
      final userId = await auth.getLoggedInId();
      final user = await GetIt.I.get<UserService>().getUserById(userId!);
      GetIt.I.get<UserService>().setCurrentUser(user!);
    }on Exception catch(e)
    {
      AppLogger.log('login exception: $e');
    }
    
    
    setState(() {  isLoggingIn = false; });

    if(GetIt.I.get<UserService>().getCurrentUser() != null) navigateToMain();
  }

  Future<void> fakeLogin() async {
    
    setState(() { isLoggingIn = true; });
    await Future.delayed(Duration(seconds: 2));
    setState(() {  isLoggingIn = false; });
  }

  Future<void> register() {
      return Future.delayed(Duration.zero);
  }

   void navigateToMain(){
    Navigator.pushNamed(context, RouteGenerator.mainRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
      
        Column(
            children: [
              Flexible(flex: 1, child: Container()),
              _buildLoginBox(context),
              Flexible(flex: 1, child: Container()),
            ],
          ),
      
      
      
      ]),
    );
  }

  Widget _buildLoginBox(BuildContext context) {
    return CardWindow(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      
                      Flexible(
                        flex: 1,
                        child: _buildHeader(context)),
                    
                      Flexible(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 36.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: 
                          [
                            _buildTextField("Email"),
                            _buildTextField("Password"),
                            _buildRegisterButton()
                          ]),
                        )),

                      Flexible(
                        flex: 1,
                        child: Column(
                          children: 
                        [
                          _buildLoginButtons()
                        ])),
                      
                    ]),);
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("Welcome", style: Theme.of(context).textTheme.headlineMedium),
    );
  }

  Widget _buildTextField(String textFieldName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(textFieldName),
            TextField(controller: textControllers[textFieldName])
          ]),
      ),
    );
  }
  
  Widget _buildLoginButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: 
      [
          _buildLoginButton(),
            ]),
    );
  }

  Widget _buildLoginButton() {
    return Row(children: [
      ElevatedLoadableButton(isLoading: isLoggingIn, onPressed: login, label: 'Login'),
    ]);
  }


  Widget _buildRegisterButton() {
    return TextButton(
      onPressed: () => register(), child: 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            child: Text("Register"),
          ));
  }
  


  

}



