import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserModel {
  final String fullName;
  // final DateTime birthDay;
  final String phoneNumber;
  final String email;
  // final String password;
  final String profilePicUrl;
  final String uid;
  // final List<String> friends;
  // final List<String> sentRequests;
  // final List<String> receivedRequests;

  const UserModel({
    required this.fullName,
    required this.phoneNumber,
    // required this.birthDay,
    // required this.gender,
    required this.email,
    // required this.password,
    required this.profilePicUrl,
    required this.uid,
    // required this.friends,
    // required this.sentRequests,
    // required this.receivedRequests,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicUrl': profilePicUrl,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'] as String,
      // birthDay: DateTime.fromMillisecondsSinceEpoch(
      //     map[FirebaseFieldNames.birthDay] as int),
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePicUrl: map['profilePicUrl'] as String,
      uid: map['uid'] as String,
      // friends: List<String>.from((map[FirebaseFieldNames.friends] ?? [])),
      // sentRequests:
      //     List<String>.from((map[FirebaseFieldNames.sentRequests] ?? [])),
      // receivedRequests:
      //     List<String>.from((map[FirebaseFieldNames.receivedRequests] ?? [])),
    );
  }
}