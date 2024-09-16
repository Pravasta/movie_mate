import 'dart:convert';

class EditUserRequestModel {
  final String? uid;
  final String? name;
  final String? photoUrl;
  final String? phoneNumber;

  EditUserRequestModel({
    this.uid,
    this.name,
    this.photoUrl,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
    };
  }

  factory EditUserRequestModel.fromMap(Map<String, dynamic> map) {
    return EditUserRequestModel(
      name: map['name'] as String,
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditUserRequestModel.fromJson(String source) =>
      EditUserRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
