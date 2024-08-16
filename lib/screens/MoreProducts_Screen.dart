import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testapp/screens/About_Product.dart';
import 'package:testapp/screens/HomeScreen.dart';
import 'package:testapp/widgets/Colors.dart';

class MoreProducts extends StatefulWidget {
  const MoreProducts({super.key});

  @override
  State<MoreProducts> createState() => _MoreProductsState();
}

class _MoreProductsState extends State<MoreProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "More Products",
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: bgcolor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Explore_products")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error${snapshot.hasError}"),
            );
          } else if (snapshot.hasData) {
            var docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                var data = docs[index].data() as Map<String, dynamic>;
                final imageUrl =
                    data.containsKey('image_url') ? data['image_url'] : null;

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 15, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutProduct(
                                    name: data["name"],
                                    amount: data["amount"],
                                    dis: data["dis"],
                                    getimage: imageUrl,
                                  )));
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 10,
                            top: 5,
                            child: Container(
                              height: 90,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(imageUrl.toString()),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          Positioned(
                              left: 120,
                              top: 15,
                              child: Text(
                                data["name"] ?? "No data",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                          Positioned(
                            top: 35,
                            left: 120,
                            child: Text(
                              data["amount"] ?? "No data",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 120,
                            top: 55,
                            child: Container(
                              width: 200,
                              height: 25,
                              child: Text(
                                data["dis"] ?? "No data",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(blurRadius: 5, color: Colors.grey)
                          ],
                          color: bgcolor,
                          borderRadius: BorderRadius.circular(10)),
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
