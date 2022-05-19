class RegisterResponseModel {
  String? token;

  RegisterResponseModel({this.token});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  get status => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
