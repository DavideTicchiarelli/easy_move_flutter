import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:easy_move_flutter/Models/User.dart' as myUser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<myUser.User?> getUserById(String userId) async {
    // Riferimento alla collezione "users" nel Firestore
    CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

    try {
      // Cerca il documento con l'ID specifico
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

      // Controlla se il documento esiste
      if (userSnapshot.exists) {
        // Converte i dati del documento in un oggetto User (sostituire con il tuo modello)
        myUser.User user = myUser.User.fromMap(userSnapshot.data() as Map<String, dynamic>);
        return user;
      } else {
        // L'utente con l'ID specifico non è stato trovato
        return null;
      }
    } catch (error) {
      print("Errore durante la ricerca dell'utente: $error");
      return null;
    }
  }

  // Metodo per l'autenticazione di un Utente
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

  // Metodo per il logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Metodo per ottenere l'oggetto utente loggato
  Future<myUser.User?> getCurrentUser() async {
    try {
      final auth.User? authUser = _auth.currentUser;
      if (authUser != null) {
        final DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(authUser.uid).get();
        if (userSnapshot.exists) {
          final userData = userSnapshot.data() as Map<String, dynamic>;
          final myUser.User currentUser = myUser.User.fromData(
            userData['id'],
            userData['name'],
            userData['surname'],
            userData['email'],
            userData['userType'],
            userData['imageUrl'],
          );
          return currentUser;
        } else {
          return null; // L'utente non è stato trovato nel Firestore
        }
      } else {
        return null; // Nessun utente autenticato
      }
    } catch (e) {
      // Gestire eventuali errori qui, ad esempio connessione al Firestore non riuscita
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(
      String email,
      void Function() onSuccess,
      void Function() onFailure,
      ) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      onSuccess();
    } catch (e) {
      onFailure();
    }
  }

  Future<void> reauthenticateAndUpdateEmail(User user, String currentMail, String newMail, String password, Function(bool, String?) callback) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(email: currentMail, password: password);

      await user.reauthenticateWithCredential(credential);

      await user.updateEmail(newMail);

      updateUserDocument(user.uid, newMail, (updateSuccess, updateMessage) {
        if (updateSuccess) {
          callback(true, "Indirizzo email aggiornato con successo");
        } else {
          callback(false, updateMessage);
        }
      });
    } catch (error) {
      callback(false, error.toString());
    }
  }

  Future<void> updateUserDocument(String userId, String newEmail, Function(bool, String?) callback) async {
    try {
      final userDocRef = _firestore.collection("users").doc(userId);

      await userDocRef.update({"email": newEmail});

      callback(true, null);
    } catch (error) {
      callback(false, "Errore durante l'aggiornamento dell'indirizzo email nel documento");
    }
  }

  Future<String> getUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid; // Restituisci l'ID dell'utente corrente
    } else {
      throw "Utente non autenticato"; // Gestisci il caso in cui l'utente non sia autenticato
    }
  }


}
