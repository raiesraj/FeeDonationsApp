import 'package:feedonations/Provider/signup_provider.dart';
import 'package:feedonations/Screens/home_page.dart';
import 'package:feedonations/Screens/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignUpAuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Fee Donations',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:const SignUpScreen(),
      ),
    );
  }
}

