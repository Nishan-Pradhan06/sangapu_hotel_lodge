class VerifyEmailModel {
  final String email;
  final String otp;

  VerifyEmailModel({required this.email, required this.otp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'email': email, 'otp': otp};
  }

  factory VerifyEmailModel.fromMap(Map<String, dynamic> map) {
    return VerifyEmailModel(
      email: map['email'] as String,
      otp: map['otp'] as String,
    );
  }
}
