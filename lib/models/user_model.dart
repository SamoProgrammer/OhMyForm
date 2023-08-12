class UserModel {
    final int id;
    final String username;
    final String phoneNumber;
    final String password;
    final String role;

    UserModel({
        required this.id,
        required this.username,
        required this.phoneNumber,
        required this.password,
        required this.role,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "phoneNumber": phoneNumber,
        "password": password,
        "role": role,
    };
}
