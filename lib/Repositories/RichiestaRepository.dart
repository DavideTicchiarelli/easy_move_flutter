import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Richiesta.dart';

class RichiestaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Funzione per memorizzare una Richiesta nel Firestore DB
  Future<String> storeRequest(Richiesta richiesta) async {
    try {

      // Aggiunta di una nuova Richiesta nella collezione 'richieste'
      final DocumentReference docRef = await _firestore
          .collection('richieste')
          .add(richiesta.toMap());

      final String documentoId = docRef.id; // Ottieni l'ID del documento

      // Aggiorna il campo "id" del documento con l'ID ottenuto
      await _firestore.collection('richieste').doc(documentoId).update({'id': documentoId});

      return "Richiesta memorizzata con successo";
    } catch (error) {
      return "Richiesta non memorizzata";
    }
  }

  // Funzione per ottenere tutte le Richieste dal Firestore DB
  Future<List<Richiesta>> getAllRichieste() async {
    try {
      // Ottieni uno snapshot di tutte le Richieste nella collezione 'richieste'
      final querySnapshot = await _firestore.collection('richieste').get();
      // Mappa i documenti in oggetti Richiesta usando il metodo fromMap()
      final richieste = querySnapshot.docs
          .map((doc) => Richiesta.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return richieste;
    } catch (error) {
      throw "Errore durante il recupero delle richieste: $error";
    }
  }

  // Aggiorna lo stato di una specifica Richiesta nel Firestore DB
  Future<String> updateRichiestaStatus(String richiestaId, String newStatus) async {
    try {
      // Aggiorna il campo 'status' del documento corrispondente alla Richiesta specificata
      await _firestore.collection('richieste').doc(richiestaId).update({
        'status': newStatus,
      });
      return('Stato della richiesta aggiornato con successo.');
    } catch (e) {
      return('Errore durante l\'aggiornamento dello stato della richiesta: $e');
    }
  }
}
