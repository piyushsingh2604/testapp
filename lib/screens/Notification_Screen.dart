import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testapp/widgets/Colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notification",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Notification").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.hasError}"),
            );
          } else if (snapshot.hasData) {
            var docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                var data = docs[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                        color: bgcolor,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/test_app_logo.png'),
                            ),
                            borderRadius: BorderRadius.circular(60)),
                      ),
                      title: Text(data["notification"] ?? "no data"),
                      subtitle: Text("Testing Notification"),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("No data found"),
            );
          }
        },
      ),
    );
  }
}
