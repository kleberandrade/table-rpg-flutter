import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:table_rpg/models/user.dart';

class Auth {
  static Future<String> signIn(String email, String password) async {
    final auth = FirebaseAuth.instance;
    final result = await auth.signInWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }

  static Future<String> signUp(String email, String password) async {
    final auth = FirebaseAuth.instance;
    final result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    return result.user.uid;
  }

  static Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  static Future<void> forgotPasswordEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  static Future<void> addUser(User user) async {
    checkUserExist(user.userId).then((value) {
      if (!value) {
        Firestore.instance
            .document("users/${user.userId}")
            .setData(user.toMap());
      }
    });
  }

  static Future<bool> checkUserExist(String userId) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$userId").get().then((doc) {
        exists = doc.exists;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static Stream<User> getUser(String userID) {
    return Firestore.instance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.documents.map((document) {
        return User.fromDocument(document);
      }).first;
    });
  }

  static String getExceptionText(Exception error) {
    if (error is PlatformException) {
      return error.message;
    } else {
      return 'Unknown error occured.';
    }
  }
}
