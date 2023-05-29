import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleSigInController with ChangeNotifier{





  final _googleSigIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;


  login() async{
    googleSignInAccount = await _googleSigIn.signIn();

    notifyListeners();

  }
  logout()async{
    googleSignInAccount = await _googleSigIn.signOut();

    notifyListeners();
  }
}