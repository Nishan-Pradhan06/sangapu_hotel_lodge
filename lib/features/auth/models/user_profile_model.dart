import 'package:intl/intl.dart';

class UserProfileModel {
  final int id;
  final String email;
  final String name;
  final String username;
  final DateTime? dateJoined;

  const UserProfileModel({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    this.dateJoined,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    if (json['date_joined'] != null) {
      parsedDate = DateTime.tryParse(json['date_joined'].toString());
    }

    return UserProfileModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      email: (json['email'] as String?) ?? '',
      name: (json['name'] as String?) ?? '',
      username: (json['username'] as String?) ?? '',
      dateJoined: parsedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'username': username,
      'date_joined': dateJoined?.toIso8601String(),
    };
  }

  UserProfileModel copyWith({
    int? id,
    String? email,
    String? name,
    String? username,
    DateTime? dateJoined,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      username: username ?? this.username,
      dateJoined: dateJoined ?? this.dateJoined,
    );
  }

  /// Preferred display name (name, or username if name is empty, or email prefix)
  String get displayName {
    if (name.trim().isNotEmpty) return name.trim();
    if (username.trim().isNotEmpty) return username.trim();
    if (email.contains('@')) return email.split('@').first;
    return 'User';
  }

  /// Initials derived from display name (e.g. "Sangapu Lodge" -> "SL")
  String get initials {
    final words = displayName.trim().split(RegExp(r'\s+'));
    if (words.length >= 2 && words[0].isNotEmpty && words[1].isNotEmpty) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty && words[0].isNotEmpty) {
      return words[0].substring(0, words[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return 'U';
  }

  /// Formatted date joined string (e.g. "02 Oct 2026")
  String get formattedDateJoined {
    if (dateJoined == null) return 'N/A';
    return DateFormat('dd MMM yyyy').format(dateJoined!.toLocal());
  }
}
