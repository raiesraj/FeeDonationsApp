import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedonations/Constant/sized_box.dart';
import 'package:feedonations/Provider/signin_provider.dart';
import 'package:feedonations/Provider/signup_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
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
        ChangeNotifierProvider(
          create: (context) => SignUpAuthProvider(),
        ),
        ChangeNotifierProvider(create: (context) => SignInProviderAuth()),
        // ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
      ],
      child: MaterialApp(
        title: 'Fee Donations',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TestingScreen(),
      ),
    );
  }
}

class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  // testIng() async {
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection("students")
  //       .doc("6WouRCcULDY9vl6U3ifWhA9r0F33")
  //       .get();
  //   print(snapshot.data().toString());
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   testIng();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Name",
                  suffixIcon: InkWell(
                      onTap: () async {
                        Map<String, dynamic> newUserData = {
                          "name": nameController.text,
                          "email": emailController.text,
                          'age': ageController.text
                        };
                        _firestore.collection("Testing").doc("12345").update({
                          "name": nameController,
                        });
                      },
                      child: Icon(Icons.edgesensor_high))),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(hintText: "Age"),
            ),
            20.ph,
            ElevatedButton(
              onPressed: () async {
                Map<String, dynamic> newUserData = {
                  "name": nameController.text,
                  "email": emailController.text,
                  'age': ageController.text
                };
                _firestore.collection("Testing").doc().set(
                      newUserData,
                    );
              },
              child: const Text("Submit"),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Testing").snapshots(),
              builder: (context, snapshot) {

                if(snapshot.connectionState == ConnectionState.active){
                  if(snapshot.hasData && snapshot.data !=null){
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index){
                            Map<String, dynamic> userMap = snapshot.data!.docs[index].data() as Map<String,dynamic>;

                            return ListTile(
                              title: Text(userMap['name']),
                            );
                          }
                      ),
                    );
                  }
                  else{
                    return const Text("No data");
                  };
                }
                else{
                  return const CircularProgressIndicator();
                }
            }
            )
          ],
        ),
      ),
    );
  }
}
