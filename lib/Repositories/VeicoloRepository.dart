import 'package:easy_move_flutter/Models/Veicolo.dart'; // Assicurati di importare la classe Veicolo
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../Models/Veicolo.dart';



class VeicoloRepository {
  final _firestore = FirebaseFirestore.instance;
  final _fireStorage = FirebaseStorage.instance;

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

  // Metodo per caricare l'immagine in Firebase Storage
  Future<String> uploadImage(File imageFile) async {
    try {
      final storageRef = _fireStorage.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');

      await storageRef.putFile(imageFile);
      final imageUrl = await storageRef.getDownloadURL();

      return imageUrl; // Restituisce l'Url dell'immagine se il caricamento è andato a buon fine
    } catch (e) {
      print('Errore durante il caricamento dell\'immagine su Firebase: $e');
      return ""; // Restituisce una Stringa vuota se il caricamento è fallito
    }
  }


  Future<List<Veicolo>> getVansCollection() async {
    List<Veicolo> vansList = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('vans').get();

      for (var van in querySnapshot.docs) {
        var data = van.data() as Map<String, dynamic>;

        Veicolo veicolo = Veicolo(
          idGuidatore: data['idGuidatore'],
          modello: data['modello'],
          targa: data['targa'],
          capienza: data['capienza'],
          tariffakm: data['tariffakm'],
          imageUrl: data['imageUrl'],
        );

        vansList.add(veicolo);
      }

      return vansList;
    } catch (e) {
      print('Errore durante il recupero dei dati da Firestore: $e');
      return [];
    }
  }















}
