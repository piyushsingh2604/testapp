import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class FavScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> favoriteProducts;
//   FavScreen({required this.favoriteProducts});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: favoriteProducts.length,
//         itemBuilder: (context, index) {
//           var products = favoriteProducts[index];
//           return ListTile(
//             title: Text(products["name"] ?? "no data"),
//           );
//         },
//       ),
//     );
//   }
// // }
//    final prefe =
//                                     await SharedPreferences.getInstance();
//                                 List<String> favList =
//                                     prefe.getStringList("fav_list") ?? [];
//                                 if (favList.contains(data["name"])) {
//                                   favList.remove(data["name"]);
//                                 } else {
//                                   favList.add(data["name"]);
//                                 }
//                                 await prefe.setStringList("fav_list", favList);

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  Future<List<String>> getfav() async {
    final prefe = await SharedPreferences.getInstance();
    return prefe.getStringList("fav_list") ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getfav(),
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
            var liss = snapshot.data!;
            return ListView.builder(
              itemCount: liss.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(liss[index]),
                );
              },
            );
          } else {
            return Center(
              child: Text("no data"),
            );
          }
        },
      ),
    );
  }
}
