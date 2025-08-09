import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/user_model.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("User cancelled Google Sign-In");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        print("Google token is null");
        return null;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) return null;

      final userModel = UserModel(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );

      await _firestore.collection('users').doc(user.uid).set(
        userModel.toFireStore(),
        SetOptions(merge: true),
      );

      return userModel;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      return true;
    } catch (e) {
      print('Error signing out: $e');
      return false;
    }
  }
}
