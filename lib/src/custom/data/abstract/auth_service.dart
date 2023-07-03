import 'package:firedart/firedart.dart';

abstract class AuthService 
{
  Future<void> loginWithEmailAndPassword(String email, String password);
  Future<String?> getLoggedInId();
  Future<bool> isLoggedIn();
}

