// Definizione della classe Veicolo
class Veicolo {
  final String idGuidatore;
  String modello;
  final String targa;
  String locazione;
  final String capienza;
  String tariffakm;
  final String imageUrl;

  // Costruttore della classe Veicolo
  Veicolo({
    required this.idGuidatore,
    required this.modello,
    required this.targa,
    required this.locazione,
    required this.capienza,
    required this.tariffakm,
    required this.imageUrl,
  });

  // Costruttore senza nome per creare un'istanza vuota di Veicolo
  Veicolo.empty()
      : idGuidatore = "",
        modello = "",
        targa = "",
        locazione="",
        capienza = "",
        tariffakm = "",
        imageUrl = "";

  // Metodo per convertire gli attributi della classe in una mappa chiave-valore
  Map<String, dynamic> toMap() {
    return {
      'idGuidatore': idGuidatore,
      'modello': modello,
      'targa': targa,
      'locazione': locazione,
      'capienza': capienza,
      'tariffakm': tariffakm,
      'imageUrl': imageUrl,
    };
  }
}
