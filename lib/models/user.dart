class UserModel {
  String firstName, lastName, email, password, password2, profilePic;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.password2,
    required this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      password2: json['password2'],
      profilePic: json['profilePic'],
    );
  }
}
