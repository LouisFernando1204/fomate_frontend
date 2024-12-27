part of 'model.dart';

class User extends Equatable {
  final String? id;
  final String? username;
  final String? email;
  final String? password;
  final int? health;

  const User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.health,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String?,
        username: json['username'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
        health: json['health'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'password': password,
        'health': health,
      };

  @override
  List<Object?> get props => [id, username, email, password, health];
}
