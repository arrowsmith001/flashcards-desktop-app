import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {

  AppConfig(this.apiKey, this.projectId, this.email, this.password);

  final String apiKey;
  final String projectId;
  final String email;
  final String password;

  static Future<AppConfig> forEnvironment(String env) async {

    var data = await rootBundle.loadString("assets/config/$env.json");
    var json = jsonDecode(data);

    return AppConfig(json['apiKey'], json['projectId'], json['email'], json['password']);
  }

}