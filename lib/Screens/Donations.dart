import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({Key? key}) : super(key: key);

  @override
  State<DonationsScreen> createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donate Now"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Testing").snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          ///Getting Data bY calling userMap
                          Map<String, dynamic> userMap =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          return Column(
                            children: [


                              // Container(
                              //   height: 100,
                              //   width: 200,
                              //   color: Colors.red,
                              //    child: Column(
                              //      children: [
                              //        Image(
                              //          fit: BoxFit.fitWidth,
                              //          height: 80,
                              //          image: NetworkImage(
                              //    userMap["profilePic"].toString(),
                              //        ),
                              //        ),
                              //        Text(userMap["name"]),
                              //      ],
                              //    )
                              // ),

                              //
                              BeautifulCard(
                                fee: userMap["fee"],
                                imageUrl: userMap["profilePic"],
                                userName: userMap["name"],
                              ),
                            ],
                          );
                        });
                  } else {
                    return const Text("No data");
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              ),
        ),
      ),
    );
  }
}

class BeautifulCard extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String fee;

  BeautifulCard({required this.imageUrl, required this.userName, required this.fee});

  void _showImagePreview(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shadowColor: Colors.black,
          child: Image.network(imageUrl),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GestureDetector(
          onTap: () {
            _showImagePreview(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUrl,
                  height: 180,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(fee),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Donate for kids to their well being',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // Button onPressed logic
              //     },
              //     child: Text('Donate Now'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


class RecentPost extends StatefulWidget {
  const RecentPost({Key? key}) : super(key: key);

  @override
  State<RecentPost> createState() => _RecentPostState();
}

class _RecentPostState extends State<RecentPost> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:Text("fag"),
    );
  }




  }

