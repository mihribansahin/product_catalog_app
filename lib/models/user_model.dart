class User {
  double? userId;
  String? email;
  String? password;
  String? phone;

  String? name;
  String? token;
  double? timeStamp;

  User(
      {this.userId,
      this.email,
      this.password,
      this.phone,
      this.name,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      name: json['name'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.userId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['token'] = this.token;

    return data;
  }
}
