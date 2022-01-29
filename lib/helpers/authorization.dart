import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fotogram/models/user.dart' as fotouser;
import 'package:fotogram/helpers/firestore.dart';
import 'package:fotogram/helpers/storage.dart';

class Authorization {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<fotouser.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return fotouser.User.fromSnapshot(snapshot);
  }

  Future<String> signUp({
    required String username,
    required String email,
    required String password,
    required Uint8List file,
  }) async {
    String result = "An error occurred.";
    try {
      if (username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          file != null) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        fotouser.User _user = fotouser.User(
          userId: credential.user!.uid,
          userName: username,
          photoUrl: "https://saurabhbansal.me/img/main_photo.jpg",
          email: email,
          bio: "",
          followers: [],
          following: [],
        );

        await _firestore
        .collection("users")
        .doc(credential.user!.uid)
        .set(_user.toJson());

        result = "Success";
      } else {
        result = "Please enter all the fields!";
      }
    } catch (error) {
      return error.toString();
    }
    return result;
  }

  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    String result = "An error occurred.";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        result = "Success";
      } else {
        result = "Please enter both fields!";
      }
    } catch (error) {
      return error.toString();
    }
    return result;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
