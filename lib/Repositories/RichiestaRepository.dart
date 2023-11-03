import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Richiesta.dart';

class RichiestaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> storeRequest(Richiesta richiesta) async {
    try {
      await _firestore
          .collection('richieste')
          .add(richiesta.toMap());
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
}
