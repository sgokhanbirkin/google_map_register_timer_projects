import 'dart:convert';

class TempModel {
  String? name;
  String? email;
  String? phone;
  TempModel({
    this.name,
    this.email,
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory TempModel.fromMap(Map<String, dynamic> map) {
    return TempModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TempModel.fromJson(String source) => TempModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
