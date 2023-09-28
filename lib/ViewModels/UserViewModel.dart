import 'package:flutter/material.dart';
import 'package:easy_move_flutter/Repositories/UserRepository.dart';


class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository();

  // Metodo per la registrazione di un nuovo utente
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


  // Metodo per l'autenticazione di un utente
  Future<String?> login(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final result = await userRepository.login(email, password);
        return result;
      } catch (e) {
        return "Errore durante il login: $e";
      }
    } else {
      return "Inserisci sia l'email che la password.";
    }
  }

  Future<String> logout() async {
    try {
      await userRepository.logout();
      return "Logout avvenuto con successo"; // Messaggio di successo
    } catch (e) {
      // Gestisci gli errori, ad esempio mostrando un messaggio all'utente
      print("Errore durante il logout: $e");
      return "Errore durante il logout: $e"; // Messaggio di errore
    }
  }

  String getCurrentUserId() {
    try {
      // Usa l'istanza di AuthManager (o del modulo in cui è definito) per chiamare getCurrentUserId
      String userId = userRepository.getCurrentUserId();
      return userId;
    } catch (e) {
      print("Errore: ${e.toString()}");
      return '';
    }
  }

}


