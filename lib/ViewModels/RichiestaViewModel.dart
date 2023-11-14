import 'package:firebase_auth/firebase_auth.dart';

import '../Models/Richiesta.dart';
import '../Repositories/RichiestaRepository.dart';
import '../Repositories/UserRepository.dart';

class RichiestaViewModel {

  final RichiestaRepository richiestaRepository = RichiestaRepository();
  final UserRepository userRepository = UserRepository();

  // Metodo per inoltrare una richiesta
  Future<String> inoltraRichiesta(
      String data,
      String iddriver,
      String description,
      String price,
      String targa,
      ) async {
    var idconsumer = await userRepository.getUserId(); // Ottiene l'ID del consumatore

    // Controlla se tutti i campi necessari sono stati compilati
    if (idconsumer.isNotEmpty && iddriver.isNotEmpty && targa.isNotEmpty && price.isNotEmpty) {
      if (data.isNotEmpty && description.isNotEmpty) {
        // Controlla se la data fornita è valida
        if (checkDate(data)) {
          // Crea un oggetto Richiesta con i dati forniti
          final richiesta = Richiesta(
            idconsumer: idconsumer,
            data: data,
            iddriver: iddriver,
            description: description,
            price: price,
            status: "Attesa",
            targa: targa,
            id: "STANDARD ID",
          );

          // Richiama il metodo storeRequest presente in richiestaRepository per la memorizzazione della richiesta in Firestore
          var message = richiestaRepository.storeRequest(richiesta);
          return message;// Restituisci una stringa contenente un messaggio quando la logica è completata con successo
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

  // Metodo per ottenere le richieste correnti in base al tipo di utente
  Future<List<Richiesta>> getRichiesteCorrenti() async {
    try {
      final user = await userRepository.getCurrentUser();
      final tutteLeRichieste = await richiestaRepository.getAllRichieste(); // Ottiene tutte le richieste
      if(user?.userType == "consumatore"){
        // Filtra le richieste in base all'ID corrente (consumatore o guidatore)
        final richiesteCorrenti = tutteLeRichieste
            .where((richiesta) =>
        richiesta.idconsumer == user?.id)
            .toList();

        return richiesteCorrenti;
      }
      else{
        // Filtra le richieste in base all'ID corrente (consumatore o guidatore)
        final richiesteCorrenti = tutteLeRichieste
            .where((richiesta) => richiesta.iddriver == user?.id)
            .toList();
        return richiesteCorrenti;
      }
    } catch (error) {
      throw "Errore durante il recupero delle richieste correnti: $error";
    }
  }

  // Filtra le richieste in base allo stato fornito e restituisce una lista filtrata
  List<Richiesta> filterRichiesteByStato(List<Richiesta> richieste, String status) {
    return richieste.where((richiesta) => richiesta.status == status).toList();
  }

  // Ottiene il conteggio delle richieste filtrate in base allo stato fornito
  String getFilteredRichiesteCount(List<Richiesta> richieste, String status) {
    List<Richiesta> filteredRichieste = richieste.where((richiesta) => richiesta.status == status).toList();
    return filteredRichieste.length.toString();
  }

  // Aggiorna lo stato di una richiesta chiamando il metodo updateRichiestaStatus prensente nella repository delle richieste
  Future<String> updateRichiestaStatus(String richiestaId, String newStatus){
    return richiestaRepository.updateRichiestaStatus(richiestaId, newStatus);
  }


}
