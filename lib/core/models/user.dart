class User {
  final String uid;
  final String email;

  User({
    required this.uid,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "uid": uid,
    };
  }
}
