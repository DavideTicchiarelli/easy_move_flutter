class Veicolo {
  final String idGuidatore;
  String modello;
  final String targa;
  String locazione;
  final String capienza;
  String tariffakm;
  final String imageUrl;

  Veicolo({
    required this.idGuidatore,
    required this.modello,
    required this.targa,
    required this.locazione,
    required this.capienza,
    required this.tariffakm,
    required this.imageUrl,
  });

  // Costruttore senza nome
  Veicolo.empty()
      : idGuidatore = "",
        modello = "",
        targa = "",
        locazione="",
        capienza = "",
        tariffakm = "",
        imageUrl = "";

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
