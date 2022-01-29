import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String userName;
  final String email;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;

  const User(
      {required this.userId,
      required this.userName,
      required this.email,
      required this.bio,
      required this.photoUrl,
      required this.followers,
      required this.following});

  static User fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      userId: snapshot["userid"],
      userName: snapshot["userName"],
      email: snapshot["email"],
      bio: snapshot["bio"],
      photoUrl: snapshot["photoUrl"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "email": email,
        "bio": bio,
        "photoUrl": photoUrl,
        "followers": followers,
        "following": following,
      };
}
