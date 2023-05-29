import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController with  ChangeNotifier{



  final _googleSigIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;


  googleLogin()async{
    googleSignInAccount = await _googleSigIn.signIn();

    userDetails = UserDetails(
    displayName: googleSignInAccount!.displayName,
    email: googleSignInAccount!.email,
      photoUrl: googleSignInAccount!.photoUrl,
    );

    notifyListeners();
  }
logOut()async{
    googleSignInAccount = await _googleSigIn.signOut();
    userDetails = null;
    notifyListeners();
}
}

class UserDetails {
   String? displayName;
   String? email;
   String? photoUrl;
   UserDetails({this.email,this.displayName,this.photoUrl});

   UserDetails.fromJson(Map<String, dynamic> json){
     displayName = json["displayName"];
     photoUrl = json["photoUrl"];
     email = json["email"];

   }
   Map<String, dynamic> toJson(){
     final Map<String, dynamic> data =  <String, dynamic>{};
     data["displayName"] = displayName;
     data["photoUrl"] = photoUrl;
     data["email"] = email;

     return data;
   }

}