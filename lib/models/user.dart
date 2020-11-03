import 'package:meta/meta.dart' show required;

class User {
  User({
    @required this.id,
    @required this.username,
    @required this.email,
    @required this.createdAt,
    @required this.updatedAt,
    @required this.avatar,
  });

  final String id;
  final String username;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        avatar: json['avatar'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "avatar": this.avatar,
      };

  User copyWith({
    String id,
    String username,
    String email,
    String avatar,
    DateTime createdAt,
    DateTime updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        avatar: avatar ?? this.avatar,
      );
}
