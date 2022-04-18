import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String id;
  String? userName;
  String? role;
  String email;

  AppUser({
    required this.id,
    this.userName,
    this.role,
    required this.email,
  });

  AppUser copyWith({
    String? id,
    String? userName,
    String? role,
    String? email,
  }) {
    return AppUser(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      role: role ?? this.role,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'role': role,
      'email': email,
    };
  }

  factory AppUser.fromMap(DocumentSnapshot doc) {
    return AppUser(
      id: doc['id'] ?? '',
      userName: doc['userName'] ?? '',
      email: doc['email'] ?? '',
    );
  }

  @override
  String toString() {
    return 'AppUser(id: $id, userName: $userName, role: $role, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.id == id &&
        other.userName == userName &&
        other.role == role &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userName.hashCode ^ role.hashCode ^ email.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userName': userName,
      'role': role,
      'email': email,
    };
  }
}
