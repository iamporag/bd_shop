import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

List<UserModel> userList = [];

class ProfileRepository {


// fetchUserFromFirestore() async {
//     final firebaseUser = await FirebaseAuth.instance.currentUser;
//     if (firebaseUser != null) {
//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(firebaseUser.uid)
//           .get()
//           .then((ds) {

//           });
//     }
//   }

  Future<UserModel> getUserInfo() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    final user = UserModel.fromMap(userData.data()!);
    return user;
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').doc(user.uid).get();
      return snapshot.data() ??
          {}; // Return user data if exists, otherwise return an empty map
    } else {
      throw Exception('User not authenticated');
    }
  }
}
