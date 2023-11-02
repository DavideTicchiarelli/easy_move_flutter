import '../Models/Richiesta.dart';
import '../Repositories/RichiestaRepository.dart';

class RichiestaViewModel {
  final RichiestaRepository _richiestaRepository = RichiestaRepository();

  Future<String> inoltraRichiesta(Richiesta richiesta) async {
    if (richiesta.idconsumer.isNotEmpty &&
        richiesta.iddriver.isNotEmpty &&
        richiesta.targa.isNotEmpty &&
        richiesta.price.isNotEmpty) {
      if (richiesta.data.isNotEmpty && richiesta.description.isNotEmpty) {
        if (checkDate(richiesta.data)) {
          try {
            final message = await _richiestaRepository.storeRequest(richiesta);
            return "Richiesta Inviata";
          } catch (error) {
            return "Errore durante l'invio della richiesta: ${error.toString()}";
          }
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
    // Implementa la logica per verificare se la data è successiva al giorno corrente
    return true; // Sostituisci con la tua logica
  }
}
