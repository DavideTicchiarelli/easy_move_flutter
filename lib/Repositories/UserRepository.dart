import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:easy_move_flutter/Models/User.dart' as myUser;
import 'package:cloud_firestore/cloud_firestore.dart';




class UserRepository {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String?> signUp(String name, String surname, String email, String password, String userType) async {

    String message;
    try {

      // Registra l'utente con Firebase Authentication
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final auth.User? authUser = _auth.currentUser;

      if (authUser != null) {
        final newUser = myUser.User.fromData(
            authUser.uid,
            name,
            surname,
            email,
            userType,
            ""
        );

        await _firestore.collection('users').doc(newUser.id).set(newUser.toMap());

        message = "Registrazione avvenuta";
      } else {
        message = "Registrazione fallita";
      }

    } catch (e) {
      message=e.toString(); // Restituisce un messaggio di errore in caso di fallimento
    }
    return message;
  }


  Future<String?> login(String email, String password) async {
    String message;
    try {
      // Effettua il login con Firebase Authentication
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      final auth.User? authUser = _auth.currentUser;

      if (authUser != null) {
        message = "Accesso avvenuto con successo";
      } else {
        message = "Accesso fallito";
      }
    } catch (e) {
      message = "Email e/o Password errati"; // Restituisce un messaggio di errore in caso di fallimento
    }
    return message;
  }

}
