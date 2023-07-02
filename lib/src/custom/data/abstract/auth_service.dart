import 'package:firedart/firedart.dart';

abstract class AuthService 
{
  Future<bool> loginWithEmailAndPassword(String email, String password);
}

