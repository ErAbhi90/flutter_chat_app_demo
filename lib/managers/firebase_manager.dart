import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_chat_app_demo/app_settings/settings.dart';

enum FirestoreCollection { users, chat }

extension FirestoreCollectionExtension on FirestoreCollection {
  String get path {
    switch (this) {
      case FirestoreCollection.users:
        return 'users';
      case FirestoreCollection.chat:
        return 'chat';
    }
  }
}

class FirebaseManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //final _logManager = GetIt.I<LogManager>();
  final _authManager = GetIt.I<AuthManager>();

  //Check user exist
  Future<DocumentSnapshot> checkUserExist(UserCredential userCredential) async {
    DocumentSnapshot userExist =
        await _firestore.collection(FirestoreCollection.users.path).doc(userCredential.user?.uid).get();
    return userExist;
  }

//Store data to firestore
  Future<void> storeUserDataToFirestore({String? imageUrl, String? username}) async {
    final photoUrl = imageUrl ?? _authManager.photoUrl;
    final name = username ?? _authManager.displayName;
    await _firestore.collection(FirestoreCollection.users.path).doc(_authManager.userID).set({
      'email': _authManager.emailAddress,
      'username': name,
      'image_url': photoUrl,
      'uid': _authManager.userID,
      'date': DateTime.now()
    });
  }

//Store image to firebase storage
  Future<void> storeImageToStorage(File? selectedImage, String? username) async {
    final storageRef = _firebaseStorage.ref().child('user_images').child('${_authManager.userID}.jpg');
    await storageRef.putFile(selectedImage!);
    final imageUrl = await storageRef.getDownloadURL();
    storeUserDataToFirestore(
      imageUrl: imageUrl,
      username: username,
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserById() async {
    return await _firestore.collection(FirestoreCollection.users.path).doc(_authManager.userID).get();
  }

  Future<void> addMessage(String message) async {
    final userData = await getUserById();
    await _firestore.collection(FirestoreCollection.chat.path).add({
      'text': message,
      'createdAt': DateTime.now(),
      'userId': _authManager.userID,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages() => _firestore
      .collection(FirestoreCollection.chat.path)
      .orderBy(
        'createdAt',
        descending: true,
      )
      .snapshots();
}
