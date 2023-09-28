import 'package:easy_move_flutter/Models/Veicolo.dart'; // Assicurati di importare la classe Veicolo
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';



class VeicoloRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<String> registerVehicle(
      String idGuidatore,
      String modello,
      String targa,
      String capienza,
      String tariffakm,
      File imageFile,
      ) async {
    String message;
    try {


        final newVeicolo = Veicolo(
          idGuidatore: idGuidatore, // Utilizzo l'ID dell'utente come chiave per il veicolo
          modello: modello,
          targa: targa,
          capienza: capienza,
          tariffakm: tariffakm,
          imageUrl: await uploadImage(imageFile),
        );

        // Registra i dati del veicolo in Firestore
        await _firestore.collection('vans').doc(newVeicolo.targa).set(newVeicolo.toMap());

        message = "Registrazione del veicolo avvenuta";

    } catch (e) {
      message = e.toString(); // Restituisce un messaggio di errore in caso di fallimento
    }
    return message;
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');

      await storageRef.putFile(imageFile);
      final imageUrl = await storageRef.getDownloadURL();

      return imageUrl; // Return the image URL after a successful upload.
    } catch (e) {
      print('Errore durante il caricamento dell\'immagine su Firebase: $e');
      return ""; // Return null in case of an error.
    }
  }
}
