import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_two/services/util_service.dart';
import 'package:flutter/material.dart';

import '../pages/sign_in_page.dart';
import 'hive_service.dart';

class AuthService{
  static final auth = FirebaseAuth.instance;

  static Future<User?> signUpUser(BuildContext context,String name, String email, String password )async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      var user = userCredential.user;
      await auth.currentUser?.updateDisplayName(name);
      return user;
    }catch(e){
      Utils.fireSnackBar(e.toString(), context);
    }
    return null;
  }
  static Future<User?> signInUser(BuildContext context, String email, String password)async{
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch(e) {
      Utils.fireSnackBar(e.toString(), context);
    }
    return null;
  }

  static Future<User?> signOutUser(BuildContext context)async{
    await auth.signOut();
    HiveService.removeData(StorageKey.uid).then((value) => Navigator.pushReplacementNamed(context, SignInPage.id));
    return null;
  }

}