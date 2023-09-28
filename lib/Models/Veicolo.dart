class Veicolo {
  final String idGuidatore;
  String modello;
  final String targa;
  final String capienza;
  String tariffakm;
  final String imageUrl;

  Veicolo({
    required this.idGuidatore,
    required this.modello,
    required this.targa,
    required this.capienza,
    required this.tariffakm,
    required this.imageUrl,
  });

  // Costruttore senza nome
  Veicolo.empty()
      : idGuidatore = "",
        modello = "",
        targa = "",
        capienza = "",
        tariffakm = "",
        imageUrl = "";

  Map<String, dynamic> toMap() {
    return {
      'idGuidatore': idGuidatore,
      'modello': modello,
      'targa': targa,
      'capienza': capienza,
      'tariffakm': tariffakm,
      'imageUrl': imageUrl,
    };
  }
}
