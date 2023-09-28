import 'package:easy_move_flutter/Repositories/VeicoloRepository.dart'; // Importa il tuo VeicoloRepository
import 'dart:io';

class VeicoloViewModel {
  final VeicoloRepository veicoloRepository = VeicoloRepository();

  Future<String> registerVehicle(
      String guidatoreId,
      String modello,
      String targa,
      String altezza,
      String lunghezza,
      String larghezza,
      String tariffakm,
      File imageFile,
      ) async {
    try {
      // Verifica che nessun campo sia vuoto prima di procedere
      if (guidatoreId.isEmpty ||
          modello.isEmpty ||
          targa.isEmpty ||
          altezza.isEmpty ||
          lunghezza.isEmpty ||
          larghezza.isEmpty ||
          tariffakm.isEmpty ) {
        return "Tutti i campi devono essere compilati";
      }

      // Verifica che altezza, larghezza, lunghezza e tariffakm siano numeri validi
      if (double.tryParse(altezza) == null ||
          double.tryParse(larghezza) == null ||
          double.tryParse(lunghezza) == null ||
          double.tryParse(tariffakm) == null) {
        return "Altezza, larghezza, lunghezza e tariffa devono essere numeri validi";
      }

      // Chiamare il metodo registerVehicle dalla tua istanza di VeicoloRepository
      String message = await veicoloRepository.registerVehicle(
        guidatoreId,
        modello,
        targa,
        calcoloCapienza(lunghezza, altezza, larghezza),
        tariffakm,
        imageFile,
      );
      return message;
    } catch (e) {
      // Gestire eventuali eccezioni qui, se necessario
      return e.toString();
    }
  }


  String calcoloCapienza(String lunghezza, String altezza, String larghezza) {
    double lunghezzaDouble = double.parse(lunghezza);
    double altezzaDouble = double.parse(altezza);
    double larghezzaDouble = double.parse(larghezza);

    double capienza = ((lunghezzaDouble * altezzaDouble * larghezzaDouble) / 1000000);
    String formattedCapienza = capienza.toStringAsFixed(2);

    return '$formattedCapienza m³';
  }


  bool isValidItalianLicensePlate(String targa) {
    // Validazione targhe italiane
    RegExp regex = RegExp(r'^[A-Z]{2}\d{3}[A-Z]{2}$');
    return regex.hasMatch(targa);
  }

}
