import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:testapp/main.dart';
import 'package:testapp/screens/About_Product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/screens/CartScreen.dart';

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({super.key});

  @override
  State<ExploreWidget> createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  Map<int, bool> favStatus = {};
  Map<int, bool> favColorStatus = {};
  Map<int, bool> addItemStatus = {};
  Map<int, bool> addItemColorStatus = {};
  List<CartItem> cartItems = []; // List to store cart items

  double get cartTotal => cartItems.fold(0, (sum, item) => sum + item.total);

  void _addToCart(String name, double amount) {
    final existingItemIndex = cartItems.indexWhere((item) => item.name == name);
    if (existingItemIndex != -1) {
      setState(() {
        cartItems[existingItemIndex].quantity++;
      });
    } else {
      setState(() {
        cartItems.add(CartItem(name: name, amount: amount));
      });
    }
  }

  void _removeFromCart(String name) {
    setState(() {
      cartItems.removeWhere((item) => item.name == name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Explore_products")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            var docs = snapshot.data!.docs;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: docs.length,
              itemBuilder: (context, index) {
                var data = docs[index].data() as Map<String, dynamic>;
                bool isfav = favStatus[index] ?? false;
                bool isfavColor = favColorStatus[index] ?? false;
                bool isadd = addItemStatus[index] ?? false;
                bool isaddColor = addItemColorStatus[index] ?? false;
                final imageUrl =
                    data.containsKey('image_url') ? data['image_url'] : null;
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    height: 215,
                    width: 140,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 7,
                          color: Color.fromARGB(53, 158, 158, 158),
                          spreadRadius: 3,
                          offset: Offset(1, 1.3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onDoubleTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(
                              cartItems: cartItems,
                              onRemove: _removeFromCart,
                            ),
                          ),
                        );
                      },
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
                      child: Stack(
                        children: [
                          Positioned(
                            top: 10,
                            left: 10,
                            right: 10,
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(imageUrl.toString()),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          Positioned(
                            top: 7,
                            left: 91,
                            child: IconButton(
                              onPressed: () async {
                                final prefe =
                                    await SharedPreferences.getInstance();
                                List<String> favList =
                                    prefe.getStringList("fav_list") ?? [];
                                if (favList.contains(data["name"])) {
                                  favList.remove(data["name"]);
                                } else {
                                  favList.add(data["name"]);
                                }
                                await prefe.setStringList("fav_list", favList);
                                setState(() {
                                  favStatus[index] = !isfav;
                                  favColorStatus[index] = !isfavColor;
                                });
                              },
                              icon: Icon(
                                isfav ? Icons.favorite : Icons.favorite_border,
                                color: isfavColor ? Colors.pink : Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 140,
                            left: 10,
                            child: Text(
                              data["name"] ?? "No name",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 155,
                            left: 10,
                            child: Text(
                              data["dis"] ?? "No description",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 175,
                            left: 10,
                            child: Row(
                              children: [
                                Text(
                                  data["amount"] ?? "no amount",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                const Gap(45),
                                IconButton(
                                  onPressed: () {
                                    _addToCart(data["name"],
                                        double.tryParse(data["amount"]) ?? 0);
                                    setState(() {
                                      addItemStatus[index] = !isadd;
                                      addItemColorStatus[index] = !isaddColor;
                                    });
                                  },
                                  icon: Icon(
                                      isadd
                                          ? Icons.check
                                          : Icons.add_circle_outlined,
                                      color: isaddColor
                                          ? Colors.green
                                          : const Color(0xFF24293D)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}


// return InkWell(
    //   onTap: () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => AboutProduct(),
    //         ));
    //   },
    //   child: Container(
    //     height: 215,
    //     width: 140,
    //     decoration: BoxDecoration(boxShadow: const [
    //       BoxShadow(
    //           blurRadius: 7,
    //           color: Color.fromARGB(53, 158, 158, 158),
    //           spreadRadius: 3,
    //           offset: Offset(
    //             1,
    //             1.3,
    //           ))
    //     ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
    //     child: Stack(
    //       children: [
    //         // image container
    //         Positioned(
    //           top: 10,
    //           left: 10,
    //           right: 10,
    //           child: Container(
    //             height: 120,
    //             width: 120,
    //             decoration: BoxDecoration(
    //                 color: Colors.green,
    //                 borderRadius: BorderRadius.circular(10)),
    //           ),
    //         ),
    //         // fav iconbutton
    //         Positioned(
    //             top: 7,
    //             left: 91,
    //             child: IconButton(
    //                 onPressed: () {
    //                   setState(() {
    //                     isfav = !isfav;
    //                     isfavColor = !isfavColor;
    //                   });
    //                 },
    //                 icon: Icon(
    //                   isfav ? Icons.favorite : Icons.favorite_border,
    //                   color: isfavColor ? Colors.pink : Colors.grey,
    //                   size: 20,
    //                 ))),

    //         // product name
    //         const Positioned(
    //             top: 140,
    //             left: 10,
    //             child: Text(
    //               "Item Name",
    //               style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    //             )),
    //         // product description
    //         const Positioned(
    //             top: 155,
    //             left: 10,
    //             child: Text(
    //               "description",
    //               style: TextStyle(
    //                   fontSize: 10,
    //                   fontWeight: FontWeight.w400,
    //                   color: Colors.grey),
    //             )),
    //         // prize and add buttion
    //         Positioned(
    //           top: 175,
    //           left: 10,
    //           child: Row(
    //             children: [
    //               const Text(
    //                 "250.00",
    //                 style: TextStyle(
    //                     color: Colors.black,
    //                     fontWeight: FontWeight.w400,
    //                     fontSize: 14),
    //               ),
    //               const Gap(45),
    //               IconButton(
    //                   onPressed: () {
    //                     setState(() {
    //                       isadd = !isadd;
    //                       isaddColor = !isaddColor;
    //                     });
    //                   },
    //                   icon: Icon(
    //                     isadd ? Icons.add_circle_outlined : Icons.check,
    //                     color:
    //                         isaddColor ? const Color(0xFF24293D) : Colors.green,
    //                   ))
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );

// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:gap/gap.dart';
// import 'package:testapp/main.dart';
// import 'package:testapp/screens/About_Product.dart';

// class ExploreWidget extends StatefulWidget {
//   const ExploreWidget({super.key});

//   @override
//   State<ExploreWidget> createState() => _ExploreWidgetState();
// }

// class _ExploreWidgetState extends State<ExploreWidget> {
//   Map<int, bool> favStatus = {};
//   Map<int, bool> favColorStatus = {};
//   Map<int, bool> addStatus = {};
//   Map<int, bool> addColorStatus = {};

//   List<Map<String, dynamic>> favoriteProducts = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('Explore Products'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FavoriteProductsScreen(
//                     favoriteProducts: favoriteProducts,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("Explore_products")
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (snapshot.hasData) {
//             var docs = snapshot.data!.docs;
//             return ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: docs.length,
//               itemBuilder: (context, index) {
//                 var data = docs[index].data() as Map<String, dynamic>;
//                 bool isfav = favStatus[index] ?? false;
//                 bool isfavColor = favColorStatus[index] ?? false;
//                 bool isadd = addStatus[index] ?? true;
//                 bool isaddColor = addColorStatus[index] ?? true;
//                 final imageUrl =
//                     data.containsKey('image_url') ? data['image_url'] : null;

//                 return Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: Container(
//                     height: 215,
//                     width: 140,
//                     decoration: BoxDecoration(
//                       boxShadow: const [
//                         BoxShadow(
//                           blurRadius: 7,
//                           color: Color.fromARGB(53, 158, 158, 158),
//                           spreadRadius: 3,
//                           offset: Offset(1, 1.3),
//                         ),
//                       ],
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AboutProduct(
//                               name: data["name"],
//                               amount: data["amount"],
//                               dis: data["dis"],
//                               getimage: imageUrl,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Stack(
//                         children: [
//                           // Image container
//                           Positioned(
//                             top: 10,
//                             left: 10,
//                             right: 10,
//                             child: Container(
//                               height: 120,
//                               width: 120,
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage(imageUrl.toString()),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                             ),
//                           ),
//                           // Fav icon button
//                           Positioned(
//                             top: 7,
//                             left: 91,
//                             child: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   favStatus[index] = !isfav;
//                                   favColorStatus[index] = !isfavColor;
//                                   if (favStatus[index]!) {
//                                     favoriteProducts.add(data);
//                                   } else {
//                                     favoriteProducts.remove(data);
//                                   }
//                                 });
//                               },
//                               icon: Icon(
//                                 isfav ? Icons.favorite : Icons.favorite_border,
//                                 color: isfavColor ? Colors.pink : Colors.grey,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                           // Product name
//                           Positioned(
//                             top: 140,
//                             left: 10,
//                             child: Text(
//                               data["name"] ?? "No name",
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           // Product description
//                           Positioned(
//                             top: 155,
//                             left: 10,
//                             child: Text(
//                               data["dis"] ?? "No description",
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                           // Price and add button
//                           Positioned(
//                             top: 175,
//                             left: 10,
//                             child: Row(
//                               children: [
//                                 Text(
//                                   data["amount"] ?? "no amount",
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                                 const Gap(45),
//                                 IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       addStatus[index] = !isadd;
//                                       addColorStatus[index] = !isaddColor;
//                                     });
//                                   },
//                                   icon: Icon(
//                                     isadd
//                                         ? Icons.add_circle_outlined
//                                         : Icons.check,
//                                     color: isaddColor
//                                         ? const Color(0xFF24293D)
//                                         : Colors.green,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Center(child: Text("No data found"));
//           }
//         },
//       ),
//     );
//   }
// }

// class FavoriteProductsScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> favoriteProducts;

//   FavoriteProductsScreen({required this.favoriteProducts});

//   @override
//   Widget build(BuildContext context) {
//     double totalAmount = favoriteProducts.fold(
//       0,
//       (sum, product) => sum + (double.tryParse(product['amount']) ?? 0),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Products'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: favoriteProducts.length,
//               itemBuilder: (context, index) {
//                 var product = favoriteProducts[index];
//                 return ListTile(
//                   title: Text(product['name'] ?? 'No name'),
//                   subtitle: Text(product['dis'] ?? 'No description'),
//                   trailing: Text(product['amount'] ?? 'No amount'),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
