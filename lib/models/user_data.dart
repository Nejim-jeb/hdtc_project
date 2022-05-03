class UserData {
  String id;
  String? userName;
  String? role;
  String email;

  UserData({
    required this.id,
    this.userName,
    this.role,
    required this.email,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.id == id &&
        other.userName == userName &&
        other.role == role &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ userName.hashCode ^ role.hashCode ^ email.hashCode;
  }
}
