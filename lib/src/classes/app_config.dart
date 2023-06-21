import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfigManager {
  
  static final AppConfigManager instance = AppConfigManager._internal();

  factory AppConfigManager() {
    return instance;
  }

  AppConfigManager._internal();

  String? apiKey;
  String? projectId;
  String? email;
  String? password;

  static Future<bool> configureForEnvironment(String env) async {

    var data = await rootBundle.loadString("assets/config/$env.json");
    var json = jsonDecode(data);

    instance.apiKey = json['apiKey'];
    instance.projectId = json['projectId'];
    instance.email = json['email'];
    instance.password = json['password'];

    return instance.apiKey != null && instance.projectId != null && instance.email != null && instance.password != null;
  }


}