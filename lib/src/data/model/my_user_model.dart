
import 'my_user_entities.dart';

class MyUser {
  String fullName;
  String phoneNumber;
  String email;
  String profilePicUrl;
  String uid;

  MyUser ({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.profilePicUrl,
    required this.uid
  });

  static final empty = MyUser(
      fullName: "",
      phoneNumber: "",
      email: "",
      profilePicUrl: "",
      uid: ""
  );

  MyUserEntity toEntity(){
    return MyUserEntity(
      fullName: fullName,
      phoneNumber: phoneNumber,
      email: email,
      profilePicUrl: profilePicUrl,
        uid:uid
    );
  }

  static MyUser formEntity(MyUserEntity entity){
    return MyUser(
        fullName: entity.fullName,
        phoneNumber: entity.phoneNumber,
        email: entity.email,
        profilePicUrl: entity.profilePicUrl,
        uid: entity.uid
    );

  }
  @override
  String toString(){
    return "MyUser: $fullName, $phoneNumber,$email, $profilePicUrl, $uid";
  }
}