import 'package:feedonations/Provider/signin_provider.dart';
import 'package:feedonations/Provider/signup_provider.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Constant/bottom_navigation.dart';
import 'Provider/homescreen_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SignUpAuthProvider(),
          ),
          ChangeNotifierProvider(create: (context) => SignInProviderAuth()),
          ChangeNotifierProvider(create: (context) => HomeScreenProvider()),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fee Donations',
          home: FutureBuilder(
            future: _checkLoginStatus(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.data == true) {
                  return EditProfileScreen();
                } else {
                  return const SignUpScreen();
                }
              }
            },
          ),
        ));
  }

  Future<bool> _checkLoginStatus() async {
    final user = _auth.currentUser;
    return user != null;
  }


}
