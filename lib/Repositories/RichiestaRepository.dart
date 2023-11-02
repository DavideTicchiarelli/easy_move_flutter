import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/Richiesta.dart';

class RichiestaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> storeRequest(Richiesta richiesta) async {
    try {
      final richiestaData = {
        'idconsumer': richiesta.idconsumer,
        'data': richiesta.data,
        'iddriver': richiesta.iddriver,
        'description': richiesta.description,
        'price': richiesta.price,
        'status': richiesta.status,
        'targa': richiesta.targa,
      };

      await _firestore.collection('richieste').add(richiestaData);
      return "Richiesta memorizzata con successo";
    } catch (error) {
      return "Richiesta non memorizzata";
    }
  }


}
