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
}
