import 'package:blogger/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] ?? "",
        name: json['name'] ?? "",
        email: json['email'] ?? "");
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? id,
  }) {
    return UserModel(
        id: id ?? this.id, name: name ?? this.name, email: email ?? this.email);
  }
}