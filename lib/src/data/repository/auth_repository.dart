import 'package:bd_shop/src/data/prefrence/local_pref.dart';
import 'package:bd_shop/src/utils/assets_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

import '../model/user_model.dart';
import '../utils/constants.dart';

class AuthRepository {
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount == null) {
        // User canceled the sign-in process
        debugPrint("User canceled the signin process.");
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
      );

      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint('User: ${authResult.user?.email}');

      if (authResult.user != null) {
        await createUserInDatabase(authResult.user!, null);
      }
      return authResult.user;
    } catch (error) {
      debugPrint("Error signing in with Google: $error");
      throw Exception(error);
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        debugPrint("Facebook login success: ${authResult.user?.email}");

        if (authResult.user != null) {
          await createUserInDatabase(authResult.user!, null);
        }

        return authResult.user;
      } else {
        debugPrint("Facebook login failed: ${result.message}");
        return null;
      }
    } catch (error) {
      debugPrint("Error signing in with Facebook: $error");
      return null;
    }
  }

  Future<User?> signInWithTwitter() async {
    try {
      final TwitterLogin twitterLogin = TwitterLogin(
          apiKey: TWITTER_API_KET,
          apiSecretKey: TWITTER_SECRET_KET,
          redirectURI: 'bdshop://');
      final result = await twitterLogin.loginV2();

      debugPrint("Twitter login status: ${result.user?.name}");

      if (result.status == TwitterLoginStatus.loggedIn) {
        final credential = TwitterAuthProvider.credential(
            accessToken: result.authToken!, secret: result.authTokenSecret!);

        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);

        debugPrint("Twitter login Success: ${authResult.user?.displayName}");

        if (authResult.user != null) {
          await createUserInDatabase(authResult.user!, null);
        }
        return authResult.user;
      } else {
        debugPrint("Twitter login Failes: ${result.errorMessage}");
        return null;
      }
    } catch (e) {
      debugPrint("Twitter login failed: ${e.toString()}");
      throw Exception(e);
    }
  }

  Future<User?> signInWithEmail(String email, String password) async{
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, password: password,
      );
    final user = userCredential.user;
    LocalPreferences.setString('username', user!.displayName ?? 'Unknown');
    LocalPreferences.setString('email', user.email ?? '');
    LocalPreferences.setString('photoURL',user.photoURL ?? AssetsManager.IMAGE_PLACE_HOLDER);
    LocalPreferences.setString('phoneNumber', user.phoneNumber ?? '');
     return userCredential.user;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createUserInDatabase(User user, String? username) async {
    final data = UserModel(
      fullName: user.displayName ?? username?? '', 
      phoneNumber: user.phoneNumber ?? '', 
      email: user.email?? '', 
      profilePicUrl: user.photoURL ?? AssetsManager.IMAGE_PLACE_HOLDER, 
      uid: user.uid
      );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(data.toMap())
        .then((value) {
      debugPrint("User Data Added: ${user.uid}");
    });
    LocalPreferences.setString('username', user.displayName ?? username!);
    LocalPreferences.setString('email', user.email ?? 'example@gmail.com');
    LocalPreferences.setString('photoURL', user.photoURL ?? AssetsManager.IMAGE_PLACE_HOLDER);
    LocalPreferences.setString('phoneNumber', user.phoneNumber ?? '+880177*******');
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<User?> signUpWithEmail(String email, password, username) async {
   try {
      final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    final user = credential.user;

    if (user != null) {
      await createUserInDatabase(user, username);
    }
    return user;
   } catch (e) {
     debugPrint("Error: $e");
     throw Exception(e);
   }
  }
}
