import 'package:flutter/material.dart';
import 'package:easy_move_flutter/Repositories/UserRepository.dart';


class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository();

  Future<String?> signUp(String name, String surname, String email, String password, String repeatPassword, String userType) async {
    if (name.isNotEmpty && surname.isNotEmpty && email.isNotEmpty && password.isNotEmpty && repeatPassword.isNotEmpty) {
      if (password == repeatPassword) {
        try {
          final result = await userRepository.signUp(name, surname, email, password, userType);
          return result;
        } catch (e) {
          return null;
        }
      } else {
        return "Le password non coincidono";
      }
    } else {
      return "Compila tutti i campi prima di procedere.";
    }
  }


  Future<String?> login(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final result = await userRepository.login(email, password);
        return result;
      } catch (e) {
        print("Errore durante il login: $e");
        return null; // Restituisci null in caso di errore
      }
    } else {
      return "Inserisci sia l'email che la password.";
    }
  }


}


