import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Richiesta.dart';

class RichiestaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> storeRequest(Richiesta richiesta) async {
    try {
      final DocumentReference docRef = await _firestore
          .collection('richieste')
          .add(richiesta.toMap());

      final String documentoId = docRef.id; // Ottieni l'ID del documento

      // Aggiorna il campo "id" del documento con l'ID ottenuto
      await _firestore.collection('richieste').doc(documentoId).update({'id': documentoId});


     // await _firestore.collection('richieste').add(richiestaData);
      return "Richiesta memorizzata con successo";
    } catch (error) {
      return "Richiesta non memorizzata";
    }
  }

  Future<List<Richiesta>> getAllRichieste() async {
    try {
      final querySnapshot = await _firestore.collection('richieste').get();
      final richieste = querySnapshot.docs
          .map((doc) => Richiesta.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return richieste;
    } catch (error) {
      throw "Errore durante il recupero delle richieste: $error";
    }
  }

  Future<String> updateRichiestaStatus(String richiestaId, String newStatus) async {
    try {
      await _firestore.collection('richieste').doc(richiestaId).update({
        'status': newStatus,
      });
      return('Stato della richiesta aggiornato con successo.');
    } catch (e) {
      return('Errore durante l\'aggiornamento dello stato della richiesta: $e');
    }
  }
}
