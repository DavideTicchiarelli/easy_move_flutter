import 'package:easy_move_flutter/Models/Veicolo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class VeicoloRepository {
  final _firestore = FirebaseFirestore.instance;
  final _fireStorage = FirebaseStorage.instance;

  //Metodo per la registrazione di un nuovo veicolo
  Future<String> registerVehicle(
      String idGuidatore,
      String modello,
      String targa,
      String locazione,
      String capienza,
      String tariffakm,
      File imageFile,
      ) async {
    String message;
    try {
      // Verifica se la targa esiste prima di inserire il veicolo
      if (await isTargaAlreadyExists(targa)) {
        // Se la targa esiste già, restituisce un messaggio di avviso
        message = "Una vettura con questa targa è già presente nel database";
      } else {
        // Se la targa non esiste già, crea un nuovo oggetto Veicolo con i dati forniti
        final newVeicolo = Veicolo(
          idGuidatore: idGuidatore,
          modello: modello,
          targa: targa,
          locazione: locazione,
          capienza: capienza,
          tariffakm: tariffakm,
          imageUrl: await uploadImage(imageFile),
        );

        // Registra i dati del veicolo in Firestore
        await _firestore
            .collection('vans')
            .doc(newVeicolo.targa)
            .set(newVeicolo.toMap());

        message = "Registrazione del veicolo avvenuta";
      }
    } catch (e) {
      message = e.toString();
    }
    return message;
  }


  // Metodo per caricare l'immagine in Firebase Storage
  Future<String> uploadImage(File imageFile) async {
    try {
      // Crea un riferimento al percorso dell'immagine nel Firebase Storage, utilizzando un timestamp univoco come parte del nome del file
      final storageRef = _fireStorage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');

      // Carica il file immagine nel Firebase Storage
      await storageRef.putFile(imageFile);

      // Ottiene l'URL di download dell'immagine dal Firebase Storage
      final imageUrl = await storageRef.getDownloadURL();

      return imageUrl; // Restituisce l'Url dell'immagine se il caricamento è andato a buon fine
    } catch (e) {
      print('Errore durante il caricamento dell\'immagine su Firebase: $e');
      return ""; // Restituisce una Stringa vuota se il caricamento è fallito
    }
  }

  // Metodo per ottenere la collezione dei veicoli dal Firestore
  Future<List<Veicolo>> getVansCollection() async {
    List<Veicolo> vansList = [];

    try {
      // Ottiene uno snapshot della collezione 'vans' dal Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('vans').get();

      // Scorre tutti i documenti ottenuti nello snapshot
      for (var van in querySnapshot.docs) {
        var data = van.data() as Map<String, dynamic>;

        // Crea un oggetto Veicolo utilizzando i dati ottenuti da ciascun documento
        Veicolo veicolo = Veicolo(
          idGuidatore: data['idGuidatore'],
          modello: data['modello'],
          targa: data['targa'],
          locazione: data['locazione'],
          capienza: data['capienza'],
          tariffakm: data['tariffakm'],
          imageUrl: data['imageUrl'],
        );

        vansList.add(veicolo); // Aggiunge il veicolo alla lista dei veicoli
      }

      return vansList; // Restituisce la lista dei veicoli recuperati dal Firestore
    } catch (e) {
      print('Errore durante il recupero dei dati da Firestore: $e');
      return [];
    }
  }

  // Metodo per il controllo della targa
  Future<bool> isTargaAlreadyExists(String targa) async {
    try {
      // Ottiene uno snapshot del documento corrispondente alla targa dalla collezione 'vans'
      final snapshot = await _firestore
          .collection('vans')
          .doc(targa)
          .get();

      return snapshot.exists; // Restituisce true se il documento (e quindi la targa) esiste, altrimenti false
    } catch (e) {
      // Gestisci l'errore qui, ad esempio, loggandolo o ritornando false in caso di errore
      return false;
    }
  }



}
