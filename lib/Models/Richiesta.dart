class Richiesta {
  final String idconsumer;
  final String data;
  final String iddriver;
  final String description;
  final String price;
  final String status;
  final String targa;

  Richiesta({
    required this.idconsumer,
    required this.data,
    required this.iddriver,
    required this.description,
    required this.price,
    required this.status,
    required this.targa,

  });

  // Costruttore senza nome
  Richiesta.fromData(this.idconsumer, this.data, this.iddriver, this.description, this.price, this.status ,this.targa);

  Map<String, dynamic> toMap() {
    return {
      'idconsumer': idconsumer,
      'data': data,
      'iddriver': iddriver,
      'description': description,
      'price': price,
      'status': status,
      'targa': targa,
    };


  }

  factory Richiesta.fromMap(Map<String, dynamic> data) {
    return Richiesta.fromData(
      data['idconsumer'] ?? '',
      data['data'] ?? '',
      data['iddriver'] ?? '',
      data['description'] ?? '',
      data['price'] ?? '',
      data['status'] ?? '',
      data['targa'] ?? ''
    );
  }

}
