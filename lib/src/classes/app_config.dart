import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  

  AppConfig();


  String? apiKey;
  String? projectId;
  String? email;
  String? password;

  Future<AppConfig> configureForEnvironment(String env) async {

    var data = await rootBundle.loadString("assets/config/$env.json");
    var json = jsonDecode(data);

    apiKey = json['apiKey'];
    projectId = json['projectId'];
    email = json['email'];
    password = json['password'];

    return this;
  }


}