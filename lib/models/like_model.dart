class like {
  int? id;
  String? email;
  String? password;
  String? name;
  String? token;
  int? timeStamp;

  like(
      {this.id,
      this.email,
      this.password,
      this.name,
      this.token,
      this.timeStamp});

  like.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    token = json['token'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['token'] = this.token;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}