import 'package:firebase_auth/firebase_auth.dart'as MyUser hide User;
import 'package:flutter/material.dart';

import '../../model/User.dart' as MyUser;
import '../remote/network/FirestoreManager.dart';

class UserProvider extends ChangeNotifier{
  MyUser.User? user;

  fetchUser()async{
    user = await FirestoreManager.getUser(MyUser.FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();
  }
}