class UserModel {
  int id;
  String name;
  String username;
  String email;
  String password;


  UserModel({required this.id, required this.name, required this.username, required this.email, required this.password});



  factory UserModel.fromJson(Map<String, dynamic> data) =>
      UserModel(
        id: data['id'],
        name: data['name'],
        username: data['username'],
        email: data['email'],
        password: data['password']

      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "email": email,
    "password": password
  };


}