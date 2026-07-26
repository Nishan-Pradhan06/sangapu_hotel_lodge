class SignUpModel {
  final String name;
  final String email;
  final String password;

  SignUpModel({required this.name, required this.email, required this.password});

  factory SignUpModel.fromMap(Map<String, dynamic> json) {
    return SignUpModel(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'password': password};
  }
}
