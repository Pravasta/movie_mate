import 'dart:convert';

class UserResponseModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? password;
  final bool? isVerified;
  final String? photoUrl;
  final String? phoneNumber;

  UserResponseModel({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.isVerified,
    this.photoUrl,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'isVerified': isVerified,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      isVerified: map['isVerified'] as bool,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) =>
      UserResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
