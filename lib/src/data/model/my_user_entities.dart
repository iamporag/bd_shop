
class MyUserEntity{
  String fullName;
  String phoneNumber;
  String email;
  String profilePicUrl;
  String uid;

  MyUserEntity({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.profilePicUrl,
    required this.uid
  });
  Map<String, Object?> toDocument(){
    return {
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
      "profilePicUrl": profilePicUrl,
      "uid": uid
    };
  }

  static MyUserEntity fromDocument(Map<String,dynamic> doc){
    return MyUserEntity(
        fullName: doc["fullName"],
        phoneNumber: doc["phoneNumber"],
        email: doc["email"],
      profilePicUrl: doc["profilePicUrl"],
      uid: doc["uid"],
    );
  }
}