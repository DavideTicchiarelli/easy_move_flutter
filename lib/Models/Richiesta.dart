// Definizione della classe Richiesta
class Richiesta {
  final String idconsumer;
  final String data;
  final String iddriver;
  final String description;
  final String price;
  final String status;
  final String targa;
  final String id;

  // Costruttore della classe Richiesta
  Richiesta({
    required this.idconsumer,
    required this.data,
    required this.iddriver,
    required this.description,
    required this.price,
    required this.status,
    required this.targa,
    required this.id


  });

  // Costruttore senza nome che utilizza i parametri come valori diretti degli attributi
  Richiesta.fromData(this.idconsumer, this.data, this.iddriver, this.description, this.price, this.status ,this.targa, this.id);

  // Metodo per convertire gli attributi della classe in una mappa chiave-valore
  Map<String, dynamic> toMap() {
    return {
      'idconsumer': idconsumer,
      'data': data,
      'iddriver': iddriver,
      'description': description,
      'price': price,
      'status': status,
      'targa': targa,
      'id': id,
    };


  }

  // Factory method per creare un'istanza di Richiesta da una mappa
  factory Richiesta.fromMap(Map<String, dynamic> data) {
    return Richiesta.fromData(
      data['idconsumer'] ?? '',
      data['data'] ?? '',
      data['iddriver'] ?? '',
      data['description'] ?? '',
      data['price'] ?? '',
      data['status'] ?? '',
      data['targa'] ?? '',
      data['id'] ?? '',
    );
  }

}
