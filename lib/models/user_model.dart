class UserModel {
  final String id;
  final String fullName;
  final String email;
  DateTime? createdAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.createdAt,
  });

  factory UserModel.fromJson(String id, Map<dynamic, dynamic> json) {
    return UserModel(
      id: id,
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      createdAt: json['createdAt'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }
} 