class RegisterRequestModel {
//  String? name;
  String? email;
  String? password;
  // String? phone;

  RegisterRequestModel({
    this.email,
    this.password,
  });

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    // name = json['name'];
    // phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    // data['phone'] = phone;
    return data;
  }
}
