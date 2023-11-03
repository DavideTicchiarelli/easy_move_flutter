import 'package:firebase_auth/firebase_auth.dart';

import '../Models/Richiesta.dart';
import '../Repositories/RichiestaRepository.dart';
import '../Repositories/UserRepository.dart';

class RichiestaViewModel {

  final RichiestaRepository richiestaRepository = RichiestaRepository();
  final UserRepository userRepository = UserRepository();

  Future<String> inoltraRichiesta(
      String data,
      String iddriver,
      String description,
      String price,
      String targa,
      ) async {
    var idconsumer = await userRepository.getUserId();
    if (idconsumer.isNotEmpty && iddriver.isNotEmpty && targa.isNotEmpty && price.isNotEmpty) {
      if (data.isNotEmpty && description.isNotEmpty) {
        if (checkDate(data)) {
          final richiesta = Richiesta(
            idconsumer: idconsumer,
            data: data,
            iddriver: iddriver,
            description: description,
            price: price,
            status: "Attesa",
            targa: targa,
          );
          var message = richiestaRepository.storeRequest(richiesta);
          return message;// Restituisci una stringa quando la logica è completata con successo
        } else {
          return "Data non valida, scegli una data successiva al giorno corrente";
        }
      } else {
        return "Compila tutti i campi della richiesta";
      }
    } else {
      return "Errore di sistema";
    }
  }

  bool checkDate(String data) {
    // Logica per controllare se la data immessa
    // è precendente alla data corrente non implementata
    return true;
  }

  Future<List<Richiesta>> getRichiesteCorrenti() async {
    try {
      final userId = await userRepository.getUserId();
      final tutteLeRichieste = await richiestaRepository.getAllRichieste();

      // Filtra le richieste in base all'ID corrente (consumatore o guidatore)
      final richiesteCorrenti = tutteLeRichieste
          .where((richiesta) =>
      richiesta.idconsumer == userId || richiesta.iddriver == userId)
          .toList();

      return richiesteCorrenti;
    } catch (error) {
      throw "Errore durante il recupero delle richieste correnti: $error";
    }
  }
}
