class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  final String userType;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.userType,
    required this.imageUrl,
  });

  // Costruttore senza nome
  User.fromData(this.id, this.name, this.surname, this.email, this.userType, this.imageUrl);

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
