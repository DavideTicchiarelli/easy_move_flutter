import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_move_flutter/Repositories/UserRepository.dart';
import 'package:easy_move_flutter/Models/User.dart' as myUser;





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


  Future<String?> getUserNameById(String userId) async {
    final user = await userRepository.getUserById(userId);
    if (user != null) {
      return user.name;
    } else {
      return null;
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

  Future<myUser.User?> getCurrentUser() async {
    return userRepository.getCurrentUser();
  }

  void sendPasswordResetEmail(
      String email,
      void Function() onSuccess,
      void Function() onFailure,
      ) {
    userRepository.sendPasswordResetEmail(email, onSuccess, onFailure);
  }

  Future<void> modifyMailWithReauthentication(String currentMail, String newMail, String password, Function(bool, String?) callback) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      callback(false, "Utente non autenticato");
      return;
    }

    try {
      await userRepository.reauthenticateAndUpdateEmail(
        user,
        currentMail,
        newMail,
        password,
            (bool success, String? message) {
          if (success) {
            callback(true, "Indirizzo email aggiornato con successo");
          } else {
            callback(false, message);
          }
        },
      );
    } catch (error) {
      callback(false, error.toString());
    }
  }



}


