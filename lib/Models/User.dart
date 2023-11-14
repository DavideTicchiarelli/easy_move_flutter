// Definizione della classe User
class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String userType;
  final String imageUrl;

  // Costruttore della classe User
  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.userType,
    required this.imageUrl,
  });

  // Costruttore senza nome che utilizza i parametri come valori diretti degli attributi
  User.fromData(this.id, this.name, this.surname, this.email, this.userType, this.imageUrl);

  // Metodo per convertire gli attributi della classe in una mappa chiave-valore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'userType': userType,
      'imageUrl': imageUrl,
    };


  }

  // Factory method per creare un'istanza di User da una mappa
  factory User.fromMap(Map<String, dynamic> data) {
    return User.fromData(
      data['id'] ?? '',
      data['name'] ?? '',
      data['surname'] ?? '',
      data['email'] ?? '',
      data['userType'] ?? '',
      data['imageUrl'] ?? '',
    );
  }

}
