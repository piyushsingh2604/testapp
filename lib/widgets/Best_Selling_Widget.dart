import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp/screens/About_Product.dart';

class BestSellingWidget extends StatefulWidget {
  const BestSellingWidget({super.key});

  @override
  State<BestSellingWidget> createState() => _BestSellingWidgetState();
}

class _BestSellingWidgetState extends State<BestSellingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("best_products").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.hasError}"),
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
                  padding: const EdgeInsets.only(left: 10, bottom: 7),
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 7,
                              color: Color.fromARGB(53, 158, 158, 158),
                              spreadRadius: 3,
                              offset: Offset(
                                1,
                                1.3,
                              ))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Stack(
                      children: [
                        // product image container
                        Positioned(
                          left: 12,
                          top: 10,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(imageUrl.toString()),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(13)),
                          ),
                        ), // product name
                        Positioned(
                            top: 12,
                            left: 75,
                            child: Text(
                              data["name"] ?? "No name",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            )), // product des
                        Positioned(
                            top: 28,
                            left: 75,
                            child: Text(
                              data["dis"] ?? "no dis",
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[400]),
                            )), // product prize
                        Positioned(
                            top: 42,
                            left: 75,
                            child: Text(
                              data["amount"] ?? "no amount",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w400),
                            )),
                        Positioned(
                            left: 230,
                            right: 15,
                            top: 30,
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
                                height: 23,
                                width: 23,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF24293D),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("no data found"),
            );
          }
        },
      ),
    );
    // backround container
    // return Container(
    //   height: 70,
    //   width: MediaQuery.of(context).size.width,
    //   decoration: BoxDecoration(boxShadow: const [
    //     BoxShadow(
    //         blurRadius: 7,
    //         color: Color.fromARGB(53, 158, 158, 158),
    //         spreadRadius: 3,
    //         offset: Offset(
    //           1,
    //           1.3,
    //         ))
    //   ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
    //   child: Stack(
    //     children: [
    //       // product image container
    //       Positioned(
    //         left: 12,
    //         top: 10,
    //         child: Container(
    //           height: 50,
    //           width: 50,
    //           decoration: BoxDecoration(
    //               color: Colors.green, borderRadius: BorderRadius.circular(13)),
    //         ),
    //       ), // product name
    //       const Positioned(
    //           top: 12,
    //           left: 75,
    //           child: Text(
    //             "Minimal Chair",
    //             style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    //           )), // product des
    //       Positioned(
    //           top: 28,
    //           left: 75,
    //           child: Text(
    //             "Lorem Ipsum",
    //             style: TextStyle(
    //                 fontSize: 9,
    //                 fontWeight: FontWeight.w400,
    //                 color: Colors.grey[400]),
    //           )), // product prize
    //       const Positioned(
    //           top: 42,
    //           left: 75,
    //           child: Text(
    //             "125.00",
    //             style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
    //           )),
    //       Positioned(
    //           left: 230,
    //           right: 15,
    //           top: 30,
    //           child: InkWell(
    //             onTap: () {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => AboutProduct(),
    //                   ));
    //             },
    //             child: Container(
    //               height: 23,
    //               width: 23,
    //               decoration: BoxDecoration(
    //                   color: const Color(0xFF24293D),
    //                   borderRadius: BorderRadius.circular(5)),
    //               child: const Center(
    //                 child: Icon(
    //                   Icons.arrow_forward_rounded,
    //                   color: Colors.white,
    //                   size: 15,
    //                 ),
    //               ),
    //             ),
    //           ))
    //     ],
    //   ),
    // );
  }
}
