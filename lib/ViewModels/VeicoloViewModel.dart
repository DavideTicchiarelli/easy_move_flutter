import 'package:easy_move_flutter/Repositories/VeicoloRepository.dart'; // Importa il tuo VeicoloRepository
import 'dart:io';

import '../Models/Veicolo.dart';

class VeicoloViewModel {
  final VeicoloRepository veicoloRepository = VeicoloRepository();

  // Metodo per lo store di un nuovo veicolo in firestore
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
          tariffakm.isEmpty) {
        return "Tutti i campi devono essere compilati";
      }

      // Verifica il formato della Targa
      if (!isValidItalianLicensePlate(targa)) {
        return "La targa non è valida. Deve essere nel formato italiano (es. AB123CD)";
      }

      // Verifica che altezza, larghezza, lunghezza e tariffakm siano numeri validi
      if (double.tryParse(altezza) == null || double.tryParse(larghezza) == null ||
          double.tryParse(lunghezza) == null || double.tryParse(tariffakm) == null) {
        return "Altezza, larghezza, lunghezza e tariffa devono essere numeri validi";
      }

      /*
      // Verifica che altezza, larghezza, lunghezza e tariffakm siano numeri positivi
      double altezzaDouble = double.parse(altezza);
      double larghezzaDouble = double.parse(larghezza);
      double lunghezzaDouble = double.parse(lunghezza);
      double tariffakmDouble = double.parse(tariffakm);

      if (altezzaDouble <= 0 || larghezzaDouble <= 0 || lunghezzaDouble <= 0 || tariffakmDouble <= 0) {
        return "Altezza, larghezza, lunghezza e tariffa devono essere numeri positivi";
      }
      */

      // Chiama il metodo registerVehicle dalla tua istanza di VeicoloRepository
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
      return e.toString();
    }
  }

  // Metodo per calcolare la capienza
  String calcoloCapienza(String lunghezza, String altezza, String larghezza) {
    double lunghezzaDouble = double.parse(lunghezza);
    double altezzaDouble = double.parse(altezza);
    double larghezzaDouble = double.parse(larghezza);

    double capienza =
        ((lunghezzaDouble * altezzaDouble * larghezzaDouble) / 1000000);
    String formattedCapienza = capienza.toStringAsFixed(2);

    return '$formattedCapienza m³';
  }

  // Metodo per validare la targa
  bool isValidItalianLicensePlate(String targa) {
    // Validazione targhe italiane
    RegExp regex = RegExp(r'^[A-Z]{2}\d{3}[A-Z]{2}$');
    return regex.hasMatch(targa);
  }

  // Metodo per fare il fetch di tutti i veicoli
  Future<List<Veicolo>> getVansList() async {
    try {
      return await veicoloRepository.getVansCollection();
    } catch (e) {
      // Gestisci eventuali eccezioni qui, se necessario
      print("Errore durante il recupero dei veicoli: $e");
      return [];
    }
  }
}
