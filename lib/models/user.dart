class User {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? gender;
  String? image;
  String? token;

  User({
    this.id,
    this.image,
    this.lastName,
    this.firstName,
    this.token,
    this.email,
    this.gender,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        image: json["image"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        email: json["email"],
        token: json["token"],
        username: json["username"],
      );
}
