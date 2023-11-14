import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_move_flutter/Repositories/UserRepository.dart';
import 'package:easy_move_flutter/Models/User.dart' as myUser;





class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository();

  // Metodo per la registrazione di un nuovo utente
  Future<String?> signUp(String name, String surname, String email, String password, String repeatPassword, String userType) async {
    //controllo se tutti i campi sono stati compilati
    if (name.isNotEmpty && surname.isNotEmpty && email.isNotEmpty && password.isNotEmpty && repeatPassword.isNotEmpty) {
      // controllo sui campi password per vedere se sono state inserite due password uguali
      if (password == repeatPassword) {
        try {
          //chiamata della funzione singUp della userRepository per effettuare la registrazione dell'utente in Firestore
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
    // controllo se i campi del login sono stati compilati
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // chiamata alla funzione login della userRepository che esegue l'autenticazione di un utente
        final result = await userRepository.login(email, password);
        return result;
      } catch (e) {
        return "Errore durante il login: $e";
      }
    } else {
      return "Inserisci sia l'email che la password.";
    }
  }


  // Metodo per ottenere il nome dell'utente tramite il suo ID
  Future<String?> getUserNameById(String userId) async {
    // chiamata alla funzione getUserId della repository per ottenere le informazioni dell'utente autenticato tramite ID
    final user = await userRepository.getUserById(userId);
    if (user != null) {
      return user.name+ " "+ user.surname;
    } else {
      return null;
    }
  }


 // Metodo per effettuare il logout dell'utente corrente
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

  //Metodo per ottenere l'utente corrente
  Future<myUser.User?> getCurrentUser() async {
    return userRepository.getCurrentUser();
  }

  // Metodo per controllare il ruolo di un utente
  Future<bool> verifyRole(String targetRole) async {
    final user = await getCurrentUser(); // Utilizza la funzione che hai già implementato per ottenere l'utente corrente

    if (user != null) {
      final userRole = user.userType; // ottenimento del ruolo dell'utente

      if (userRole != null && userRole.isNotEmpty) {
        return userRole == targetRole; // Restituisci true se il ruolo corrisponde al targetRole specificato, altrimenti false
      }
    }
    return false; // Restituzione predefinita se l'utente non ha un ruolo o se l'utente non è autenticato
  }


  // Metodo per inviare una mail per il reset della password
  void sendPasswordResetEmail(
      String email,
      void Function() onSuccess,
      void Function() onFailure,
      ) {
    userRepository.sendPasswordResetEmail(email, onSuccess, onFailure);
  }

  // Metodo per modificare l'email richiedendo nuovamente l'autenticazione dell'utente
  Future<void> modifyMailWithReauthentication(String currentMail, String newMail, String password, Function(bool, String?) callback) async {
    User? user = FirebaseAuth.instance.currentUser;

    // Se l'utente non è autenticato, restituisce un messaggio di errore tramite il callback
    if (user == null) {
      callback(false, "Utente non autenticato");
      return;
    }

    try {
      // Richiama il metodo per riautenticare l'utente e aggiornare l'email
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


