import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app_demo/managers/log_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum FirestoreCollection { users }

extension FirestoreCollectionExtension on FirestoreCollection {
  String get path {
    switch (this) {
      case FirestoreCollection.users:
        return 'users';
    }
  }
}

class FirebaseManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final logManager = GetIt.I<LogManager>();

//Google Sign In
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        //Create New credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential = await _auth.signInWithCredential(credential);

        DocumentSnapshot userExist = await _checkUserExist(userCredential);

        if (userExist.exists) {
          logManager.logInfo('User Already Exists in Database');
        } else {
          await _storeUserDataToFirestore(userCredential);
        }
      }
    } on FirebaseAuthException catch (e) {
      logManager.logError(e.toString());
    }
  }

  //Check user exist
  Future<DocumentSnapshot> _checkUserExist(UserCredential userCredential) async {
    DocumentSnapshot userExist =
        await _firestore.collection(FirestoreCollection.users.path).doc(userCredential.user?.uid).get();
    return userExist;
  }

//Store data to firestore
  Future<void> _storeUserDataToFirestore(UserCredential userCredential) async {
    await _firestore.collection(FirestoreCollection.users.path).doc(userCredential.user!.uid).set({
      'email': userCredential.user?.email,
      'name': userCredential.user?.displayName,
      'image': userCredential.user?.photoURL,
      'uid': userCredential.user?.uid,
      'date': DateTime.now()
    });
  }
}
